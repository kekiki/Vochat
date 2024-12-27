import 'dart:math';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:colive/common/adapts/colive_screen_adapt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';
import '../services/repositories/colive_card_repository.dart';
import '../services/widgets/dialogs/report/colive_report_dialog.dart';
import '../services/managers/colive_call_invitation_manager.dart';
import '../services/managers/colive_profile_manager.dart';
import '../services/models/colive_anchor_model.dart';
import '../services/models/colive_moment_item_model.dart';
import '../services/repositories/colive_anchor_repository.dart';
import '../services/routes/colive_routes.dart';
import 'colive_anchor_detail_state.dart';
import 'more_moment/colive_more_moment_page.dart';
import 'more_video/colive_more_video_page.dart';

class ColiveAnchorDetailController extends ColiveBaseController {
  final state = ColiveAnchorDetailState();
  final _anchorRepository = Get.find<ColiveAnchorRepository>();
  final _cardRepository = Get.find<ColiveCardRepository>();
  final scrollController = ScrollController();
  final sliderController = CarouselSliderController();
  final imageScrollController = ScrollController();

  @override
  void onInit() {
    state.anchorInfoObs.value = Get.arguments;
    state.profileObs.value = ColiveProfileManager.instance.userInfo;
    state.haveFreeCallCard.value =
        ColiveProfileManager.instance.hasFreeCallCard;
    _setupAnchorAlbumList();
    super.onInit();

    _fetchAnchorInfo();
    _fetchMomentList();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScrollOffsetChanged);
    scrollController.dispose();
    imageScrollController.dispose();
    super.dispose();
  }

  @override
  void setupListener() {
    subsriptions.add(database.anchorDao
        .findAnchorByIdAsStream(state.anchorInfoObs.value.id)
        .listen((anchorInfo) {
      if (anchorInfo == null) return;
      state.anchorInfoObs.value = anchorInfo;
      _setupAnchorAlbumList();
    }));
    subsriptions.add(ColiveProfileManager.instance.profileStream.listen((user) {
      state.profileObs.value = user;
    }));
    subsriptions.add(_cardRepository.getCardList().listen((list) {
      if (list == null) return;
      state.haveFreeCallCard.value =
          list.any((element) => element.isFreeCallCard);
    }));
    scrollController.addListener(_onScrollOffsetChanged);
  }

  void onTapImagePage(int index) {
    sliderController.animateToPage(index);
  }

  void onPageChanged(int index) {
    state.currentImageIndexObs.value = index;
    if (index < 3) {
      imageScrollController.animateTo(
        imageScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    } else {
      imageScrollController.animateTo(
        min(imageScrollController.position.maxScrollExtent,
            30.pt * (index - 3)),
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void _setupAnchorAlbumList() {
    state.albumListObs.clear();
    state.albumListObs.value = [
          ColiveAnchorModelAlbum.fromJson(
              {'images': state.anchorInfoObs.value.avatar})
        ] +
        state.anchorInfoObs.value.album;
  }

  void _onScrollOffsetChanged() {
    final offset = max(scrollController.offset, 0);
    final alpha = min(1.0, offset / state.headerVisibleExtent);
    state.appBarAlphaObs.value = alpha;
  }

  void _fetchAnchorInfo() {
    _anchorRepository.fetchAnchorInfo(
      isRobot: state.anchorInfoObs.value.isRobot,
      anchorId: state.anchorInfoObs.value.id,
      ignoreCache: true,
      fetchVideos: true,
    );
  }

  void _fetchMomentList() async {
    final anchorId = state.anchorInfoObs.value.id;
    state.momentListObs.value =
        await database.momentDao.findMomentListByAnchorId(anchorId);
    final result =
        await apiClient.fetchAnchorMomentList('$anchorId', '1', '10');
    if (result.isSuccess && result.data != null) {
      _saveMomentList(result.data!);
    }
  }

  Future<void> _saveMomentList(List<ColiveMomentItemModel> list) async {
    List<ColiveMomentItemModel> momentList = [];
    for (var element in list) {
      var moment = await database.momentDao.findMomentById(element.id);
      if (moment == null) {
        momentList.add(element);
        database.momentDao.insertMoment(element);
      } else {
        moment = element.copyWith(
          isLike: moment.isLike,
          likeNum: moment.likeNum,
        );
        momentList.add(moment);
        database.momentDao.insertMoment(moment);
      }
    }
    state.momentListObs.value = momentList;
  }

  void onTapReport() {
    ColiveDialogUtil.showDialog(
      const ColiveReportDialog(),
      arguments: state.anchorInfoObs.value,
    );
  }

  void onTapImage(List<ColiveAnchorModelAlbum> imageList, int index) {
    Get.toNamed(ColiveRoutes.anchorPhotos, arguments: {
      'list': imageList,
      'index': index,
    });
  }

  void onTapVideo(ColiveAnchorModelVideo video) {
    final videos = state.anchorInfoObs.value.videos;
    final index = videos.indexOf(video);
    Get.toNamed(ColiveRoutes.anchorVideos, arguments: {
      'index': index,
      'list': videos,
    });
  }

  Future<void> onTapFollow() async {
    _anchorRepository.requestFollow(anchor: state.anchorInfoObs.value);
  }

  void onTapChat() {
    Get.toNamed(
      ColiveRoutes.chat,
      arguments: state.anchorInfoObs.value.sessionId,
    );
  }

  void onTapCall() {
    ColiveCallInvitationManager.instance.sendCallInvitation(
      anchor: state.anchorInfoObs.value,
    );
  }

  void onTapMoreVideo() {
    Get.to(
      () => const ColiveMoreVideoPage(),
      arguments: state.anchorInfoObs.value,
    );
  }

  void onTapMoreMoment() {
    Get.to(
      () => const ColiveMoreMomentPage(),
      arguments: state.anchorInfoObs.value,
    );
  }
}
