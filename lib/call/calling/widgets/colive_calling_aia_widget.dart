import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../common/adapts/colive_screen_adapt.dart';
import '../../../services/managers/colive_download_manager.dart';

class ColiveCallingAiaWidget extends StatefulWidget {
  const ColiveCallingAiaWidget({
    super.key,
    required this.videoUri,
    required this.onPlayProgress,
    required this.onPlayEnd,
    required this.onPlayFailed,
  });

  final String videoUri;
  final ValueChanged<int> onPlayProgress;
  final ValueChanged<int> onPlayEnd;
  final ValueChanged<Object> onPlayFailed;

  @override
  State<ColiveCallingAiaWidget> createState() => _ColiveCallingAiaWidgetState();
}

class _ColiveCallingAiaWidgetState extends State<ColiveCallingAiaWidget> {
  late VideoPlayerController playerController;

  List<StreamSubscription> streams = [];
  final isBufferingObs = false.obs;
  bool isPrepared = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  @override
  void dispose() {
    playerController.removeListener(_playerListener);
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isPrepared) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: _buildLoading(),
      );
    }

    final radio = playerController.value.aspectRatio;
    return Container(
      width: ColiveScreenAdapt.screenWidth,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: radio > 1
                    ? ColiveScreenAdapt.screenHeight * radio
                    : ColiveScreenAdapt.screenWidth,
                height: radio > 1
                    ? ColiveScreenAdapt.screenHeight
                    : ColiveScreenAdapt.screenWidth / radio,
                child: AspectRatio(
                  aspectRatio: playerController.value.aspectRatio,
                  child: VideoPlayer(playerController),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Obx(() {
              return Visibility(
                visible: isBufferingObs.value,
                child: Center(
                  child: _buildLoading(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      width: 50.pt,
      height: 50.pt,
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  void _initPlayer() async {
    try {
      final isDownloaded =
          await ColiveDownloadManager.instance.isDownloaded(widget.videoUri);
      if (isDownloaded) {
        final path =
            ColiveDownloadManager.instance.downloadPathWithUrl(widget.videoUri);
        playerController = VideoPlayerController.file(File(path));
        await playerController.initialize();
        _addListenerAndPlay();
      } else {
        playerController =
            VideoPlayerController.networkUrl(Uri(path: widget.videoUri));
        playerController.initialize().then((value) {
          _addListenerAndPlay();
        }).onError((err, stackTrace) async {
          final file =
              await ColiveDownloadManager.instance.download(widget.videoUri);
          if (file == null) {
            widget.onPlayFailed(err!);
            return;
          }
          playerController = VideoPlayerController.file(File(file.path));
          await playerController.initialize();
          _addListenerAndPlay();
        });
      }
    } catch (e) {
      widget.onPlayFailed(e);
    }
  }

  void _addListenerAndPlay() {
    playerController.addListener(_playerListener);
    playerController.setVolume(0); //静音
    playerController.play();
    isPrepared = true;
    if (mounted) setState(() {});
  }

  void _playerListener() {
    final value = playerController.value;
    isBufferingObs.value = value.isBuffering;
    final position = value.position.inSeconds;
    final duration = value.duration.inSeconds;
    if (duration > 0 && position > 0) {
      widget.onPlayProgress(position);
    }
    if (value.isCompleted) {
      widget.onPlayEnd(duration);
    }
  }
}
