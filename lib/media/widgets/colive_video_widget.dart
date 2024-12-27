import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:colive/generated/assets.dart';
import 'package:colive/services/managers/colive_download_manager.dart';
import 'package:colive/services/static/colive_colors.dart';
import 'package:video_player/video_player.dart';

import '../../common/event_bus/colive_event_bus.dart';
import '../../common/utils/colive_format_util.dart';
import '../../services/managers/colive_event_bus_event.dart';
import '../../services/static/colive_styles.dart';

class ColiveVideoWidget extends StatefulWidget {
  const ColiveVideoWidget({super.key, required this.videoUri});

  final String videoUri;

  @override
  State<ColiveVideoWidget> createState() => _ColiveVideoWidgetState();
}

class _ColiveVideoWidgetState extends State<ColiveVideoWidget> {
  late VideoPlayerController playerController;

  final List<StreamSubscription> subsriptions = [];

  final currentPositionObs = 0.obs;
  final totalDurationObs = 0.obs;
  final isPlayingObs = false.obs;
  final isBufferingObs = false.obs;

  bool isSeek = false;
  bool isPrepared = false;
  bool isFailed = false;

  @override
  void initState() {
    super.initState();

    _setupListener();
    _initPlayer();
  }

  @override
  void dispose() {
    _clear();
    playerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ColiveVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupListener();
  }

  void _setupListener() {
    _clear();
    subsriptions.add(
        ColiveEventBus.instance.on<ColiveCallBeginEvent>().listen((event) {
      if (isPlayingObs.value) {
        playerController.pause();
        isPlayingObs.value = false;
      }
    }));
  }

  void _clear() {
    for (var stream in subsriptions) {
      stream.cancel();
    }
    subsriptions.clear();
  }

  @override
  Widget build(BuildContext context) {
    // if (isFailed) {
    //   return Container(
    //     color: Colors.black,
    //     alignment: Alignment.center,
    //     child: Icon(
    //       Icons.warning_rounded,
    //       size: 40.pt,
    //       color: Colors.grey,
    //     ),
    //   );
    // }

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
            child: ClipRect(
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                child: SizedBox(
                  width: radio > 1
                      ? ColiveScreenAdapt.screenHeight * radio
                      : ColiveScreenAdapt.screenWidth,
                  height: radio > 1
                      ? ColiveScreenAdapt.screenHeight
                      : ColiveScreenAdapt.screenWidth / radio,
                  child: AspectRatio(
                    aspectRatio: radio,
                    child: VideoPlayer(playerController),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            bottom: 0,
            end: 0,
            child: _buildControlWidget(),
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

  Widget _buildControlWidget() {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 24.pt),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10.pt),
          Container(
            width: 25.pt,
            height: 25.pt,
            margin: EdgeInsetsDirectional.only(start: 5.pt),
            child: IconButton(
              onPressed: () => _onTapPlay(),
              padding: EdgeInsets.zero,
              iconSize: 25.pt,
              icon: Obx(() {
                return Image.asset(
                  isPlayingObs.value
                      ? Assets.imagesColiveVideoPause
                      : Assets.imagesColiveVideoPlay,
                  width: 25.pt,
                  height: 25.pt,
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          SizedBox(width: 10.pt),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 7.pt),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4.pt,
                    activeTrackColor: ColiveColors.primaryColor,
                    inactiveTrackColor: Colors.white,
                    thumbColor: ColiveColors.primaryColor,
                    overlayColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(
                      disabledThumbRadius: 5.pt,
                      enabledThumbRadius: 5.pt,
                      elevation: 0,
                      pressedElevation: 0,
                    ),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 5.pt),
                  ),
                  child: Obx(() {
                    return Slider(
                      min: 0,
                      max: totalDurationObs.value.toDouble(),
                      value: currentPositionObs.value.toDouble(),
                      onChanged: (double value) =>
                          currentPositionObs.value = value.toInt(),
                      onChangeStart: (double value) => isSeek = true,
                      onChangeEnd: (double value) =>
                          _onSeekChanced(value.toInt()),
                    );
                  }),
                ),
                SizedBox(height: 5.pt),
                Row(
                  children: [
                    SizedBox(width: 5.pt),
                    Obx(() {
                      return Text(
                        ColiveFormatUtil.durationToTime(
                            currentPositionObs.value,
                            isShowHour: false),
                        style: ColiveStyles.body14w400.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }),
                    const Spacer(),
                    Obx(() {
                      return Text(
                        ColiveFormatUtil.durationToTime(
                            totalDurationObs.value,
                            isShowHour: false),
                        style: ColiveStyles.body14w400.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }),
                    SizedBox(width: 5.pt),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.pt),
        ],
      ),
    );
  }

  void _initPlayer({bool isRetry = false}) async {
    try {
      if (widget.videoUri.isURL) {
        if (await ColiveDownloadManager.instance
            .isDownloaded(widget.videoUri)) {
          final path = ColiveDownloadManager.instance
              .downloadPathWithUrl(widget.videoUri);
          playerController = VideoPlayerController.file(File(path));
        } else {
          playerController =
              VideoPlayerController.networkUrl(Uri(path: widget.videoUri));
          //在线播放失败就下载播放
          ColiveDownloadManager.instance
              .download(widget.videoUri)
              .then((value) {
            if (!isPrepared && !isRetry && mounted) {
              _initPlayer(isRetry: true);
            }
          });
        }
      } else {
        playerController = VideoPlayerController.file(File(widget.videoUri));
      }
      await playerController.initialize();
      playerController.addListener(() {
        final value = playerController.value;
        isBufferingObs.value = value.isBuffering;
        isPlayingObs.value = value.isPlaying;
        if (isSeek) return;
        currentPositionObs.value = value.position.inSeconds;
      });
      totalDurationObs.value = playerController.value.duration.inSeconds;
      // playerController.play();
      isPrepared = true;
    } catch (e) {
      isFailed = true;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onTapPlay() {
    if (isPlayingObs.value) {
      playerController.pause();
      isPlayingObs.value = false;
    } else {
      playerController.play();
      isPlayingObs.value = true;
    }
  }

  void _onSeekChanced(int value) async {
    await playerController.seekTo(Duration(seconds: value.toInt()));
    isSeek = false;
  }
}
