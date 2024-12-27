import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/common/utils/colive_path_util.dart';
import 'package:colive/common/extensions/colive_string_ext.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_download_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../services/models/colive_anchor_model.dart';
import '../../services/models/colive_login_model.dart';
import '../../services/static/colive_colors.dart';

class ColiveAnchorVideoCover extends StatefulWidget {
  const ColiveAnchorVideoCover({
    super.key,
    required this.videoModel,
    required this.profile,
    required this.onTap,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
  });

  final ColiveAnchorModelVideo videoModel;
  final ColiveLoginModelUser profile;
  final ValueChanged<ColiveAnchorModelVideo> onTap;

  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final BoxFit fit;

  @override
  State<ColiveAnchorVideoCover> createState() =>
      _ColiveAnchorVideoCoverState();
}

class _ColiveAnchorVideoCoverState extends State<ColiveAnchorVideoCover> {
  String get videoUrl => widget.videoModel.video;
  File? _coverFile;

  @override
  void initState() {
    super.initState();

    _loadCoverFile();
  }

  void _loadCoverFile() async {
    final file =
        File('${ColivePathUtil.downloadPath}${videoUrl.md5}_target.webp');
    if (await file.exists()) {
      _coverFile = file;
      if (mounted) setState(() {});
      return;
    }

    String videoPath = videoUrl;
    if (await ColiveDownloadManager.instance.isDownloaded(videoUrl)) {
      videoPath =
          ColiveDownloadManager.instance.downloadPathWithUrl(videoUrl);
    }
    final bytes = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.WEBP,
      maxWidth: ColiveScreenAdapt.screenWidth.toInt(),
      quality: 50,
    );
    if (bytes != null) {
      _coverFile = await file.writeAsBytes(bytes);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUserVIP = widget.profile.isVIP;
    final isShowVIP = widget.videoModel.isVip == 1 && !isUserVIP;
    return GestureDetector(
      onTap: () => widget.onTap(widget.videoModel),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: Stack(
            children: [
              Positioned.fill(
                child: _coverFile != null
                    ? Image.file(
                        _coverFile!,
                        width: widget.width,
                        height: widget.height,
                        fit: widget.fit,
                      )
                    : Image.asset(
                        Assets.imagesColiveAvatarAnchor,
                        width: widget.width,
                        height: widget.height,
                        fit: widget.fit,
                      ),
              ),
              Positioned.fill(
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  color: rgba(0, 0, 0, 0.2),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    Assets.imagesColiveVideoPlay,
                    width: 30.pt,
                    height: 30.pt,
                  ),
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: isShowVIP,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesColiveVideoPlay,
                          width: 30.pt,
                          height: 30.pt,
                        ),
                        SizedBox(height: 6.pt),
                        Image.asset(
                          Assets.imagesColiveVipMedia,
                          width: 30.pt,
                          height: 30.pt,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
