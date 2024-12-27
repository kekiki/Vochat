import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:colive/services/routes/colive_routes.dart';
import 'package:colive/services/widgets/colive_base_controller.dart';

import '../../media/colive_media_model.dart';
import '../../services/models/colive_system_message_model.dart';

class ColiveSystemMessageController extends ColiveBaseController {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final messageListObs = <ColiveSystemMessageModel>[].obs;
  int currentPage = 1;
  final isLoadFailedObs = false.obs;

  void onRefresh() async {
    currentPage = 1;
    final result = await apiClient.fetchSystemMessageList('$currentPage');
    if (result.isSuccess && result.data != null) {
      if (result.data!.isEmpty) {
        messageListObs.value = [
          ColiveSystemMessageModel.createDefaultModel()
        ];
      } else {
        messageListObs.value = result.data!;
      }
      refreshController.finishRefresh(IndicatorResult.success);
    } else {
      isLoadFailedObs.value = messageListObs.isEmpty;
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoadMore() async {
    currentPage++;
    final result = await apiClient.fetchSystemMessageList('$currentPage');
    if (result.isSuccess && result.data != null) {
      if (result.data!.isEmpty) {
        refreshController.finishLoad(IndicatorResult.noMore);
      } else {
        messageListObs.value = result.data!;
        refreshController.finishLoad(IndicatorResult.success);
      }
    } else {
      currentPage--;
      refreshController.finishLoad(IndicatorResult.fail);
    }
  }

  void onTapMessage(ColiveSystemMessageModel model) {
    if (model.link.isEmpty) return;
    Get.toNamed(ColiveRoutes.web, arguments: {'url': model.link});
  }

  void onTapImage(ColiveSystemMessageModel model) {
    if (model.images.isEmpty) return;
    final mediaList = [
      ColiveMediaModel(type: ColiveMediaType.photo, path: model.images)
    ];
    Get.toNamed(ColiveRoutes.media, arguments: {
      'index': 0,
      'list': mediaList,
    });
  }
}
