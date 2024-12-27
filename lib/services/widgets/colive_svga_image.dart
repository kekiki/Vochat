import 'dart:io';

import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../../common/logger/colive_log_util.dart';
import '../managers/colive_download_manager.dart';

class ColiveSvgaImage extends StatefulWidget {
  const ColiveSvgaImage(
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
  State<ColiveSvgaImage> createState() => _ColiveSvgaImageState();
}

class _ColiveSvgaImageState extends State<ColiveSvgaImage>
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
          await ColiveDownloadManager.instance.isDownloaded(widget.url);
      if (!isDownloaded) {
        final file =
            await ColiveDownloadManager.instance.download(widget.url);
        filePath = file?.path;
      } else {
        filePath =
            ColiveDownloadManager.instance.downloadPathWithUrl(widget.url);
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
      ColiveLogUtil.e('SvgaImage', e.toString());
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
