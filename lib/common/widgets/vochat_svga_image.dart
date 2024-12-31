import 'dart:io';

import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../../common/logger/vochat_log_util.dart';
import '../../services/managers/vochat_download_manager.dart';

class VochatSvgaImage extends StatefulWidget {
  const VochatSvgaImage(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.filterQuality = FilterQuality.low,
    this.allowDrawingOverflow,
    this.clearsAfterStop = true,
    this.preferredSize,
    this.borderRadius = BorderRadius.zero,
    this.placeholderWidget,
    this.placeholder,
  });

  final String url;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final bool? allowDrawingOverflow;
  final bool clearsAfterStop;
  final Size? preferredSize;
  final BorderRadiusGeometry borderRadius;

  final Widget? placeholderWidget;
  final String? placeholder;

  @override
  State<VochatSvgaImage> createState() => _VochatSvgaImageState();
}

class _VochatSvgaImageState extends State<VochatSvgaImage>
    with TickerProviderStateMixin {
  late SVGAAnimationController animateController;

  @override
  void initState() {
    animateController = SVGAAnimationController(vsync: this);
    super.initState();

    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      String? filePath;
      final isDownloaded =
          await VochatDownloadManager.instance.isDownloaded(widget.url);
      if (!isDownloaded) {
        final file = await VochatDownloadManager.instance.download(widget.url);
        filePath = file?.path;
      } else {
        filePath =
            VochatDownloadManager.instance.downloadPathWithUrl(widget.url);
      }
      if (filePath != null) {
        final bytes = await File(filePath).readAsBytes();
        var videoItem = await SVGAParser.shared.decodeFromBuffer(bytes);
        animateController.videoItem = videoItem;
      } else {
        var videoItem = await SVGAParser.shared.decodeFromURL(widget.url);
        animateController.videoItem = videoItem;
      }
      animateController.repeat();
      if (mounted) setState(() {});
    } catch (e) {
      VochatLogUtil.e('SvgaImage', e.toString());
    }
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Visibility(
        visible: animateController.videoItem != null,
        replacement: _buildPlaceholder(),
        child: SVGAImage(
          animateController,
          fit: widget.fit,
          filterQuality: widget.filterQuality,
          allowDrawingOverflow: widget.allowDrawingOverflow,
          clearsAfterStop: widget.clearsAfterStop,
          preferredSize: widget.preferredSize,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    if (widget.placeholderWidget != null) {
      return widget.placeholderWidget!;
    } else if (widget.placeholder != null) {
      return Image.asset(
        widget.placeholder!,
        width: widget.preferredSize?.width,
        height: widget.preferredSize?.height,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox(
        width: widget.preferredSize?.width,
        height: widget.preferredSize?.height,
      );
    }
  }
}
