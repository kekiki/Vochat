import 'dart:async';

import 'package:get/get.dart';
import 'package:vochat/common/utils/vochat_loading_util.dart';
import 'package:vochat/common/extensions/vochat_api_response_ext.dart';

import '../../common/api/vochat_api_client.dart';
import '../../common/preference/vochat_preference.dart';
import '../../common/widgets/dialogs/vochat_dialog_util.dart';
import '../../common/widgets/dialogs/vochat_topup_to_account_dialog.dart';
import '../../common/database/vochat_database.dart';
import '../../services/models/vochat_api_response.dart';
import '../../common/routes/vochat_routes.dart';
import '../models/cochat_user_model.dart';

class VochatProfileManager {
  bool _isLogout = false;
  VochatProfileManager._internal();

  static VochatProfileManager? _instance;
  static VochatProfileManager get instance =>
      _instance ??= VochatProfileManager._internal();

  final List<StreamSubscription> subsriptions = [];

  final _apiClient = Get.find<VochatApiClient>();
  final _appDatabase = Get.find<VochatDatabase>();

  final StreamController<CochatUserModel> _streamController =
      StreamController.broadcast();
  CochatUserModel _userInfo =
      CochatUserModel.fromJson(VochatPreference.userInfoJson);

  CochatUserModel get userInfo => _userInfo;
  Stream<CochatUserModel> get profileStream => _streamController.stream;

  Future<void> login(CochatUserModel userModel) async {
    if (userModel.id != _userInfo.id) {
      await _clearDatabase();
    }
    _isLogout = false;
    VochatPreference.token = userModel.token;
    VochatPreference.userId = userModel.id.toString();
    updateLocalInfo(userModel);
    Get.offAllNamed(VochatRoutes.tabs);
  }

  Future<void> logout() async {
    if (_isLogout) return;
    _isLogout = true;
    VochatPreference.token = "";
    VochatPreference.userId = "";
    _streamController.close();
    _instance = null;
    Get.offAllNamed(VochatRoutes.login);
  }

  Future<void> deleteAccount() async {
    VochatLoadingUtil.show();
    final result = await _apiClient.deleteAccount().response;
    if (result.isSuccess) {
      await VochatPreference.clear();
      await _clearDatabase();
      VochatLoadingUtil.dismiss();
      logout();
    } else {
      VochatLoadingUtil.dismiss();
      VochatLoadingUtil.showToast(result.msg);
    }
  }

  Future<VochatApiResponse<CochatUserModel>> fetchProfile() async {
    final result =
        await _apiClient.fetchUserInfo(userId: userInfo.id.toString()).response;
    final data = result.data;
    if (result.isSuccess && data != null) {
      _isLogout = false;
      updateLocalInfo(data, true);
    }
    return result;
  }

  Future<void> updateDiamondsAndVipDate(int diamonds, int vipDate) async {
    // if (diamonds != _userInfo.diamonds || vipDate != _userInfo.vipDate) {
    //   final user = _userInfo.copyWith(diamonds: diamonds, vipDate: vipDate);
    //   await updateLocalInfo(user, true);
    // }
  }

  Future<void> updateLocalInfo(CochatUserModel userInfo,
      [bool isEvent = false]) async {
    showTopupToAccountDialogIfNeeded(oldUser: _userInfo, newUser: userInfo);
    _userInfo = userInfo;
    if (isEvent) {
      _streamController.add(userInfo);
    }
    VochatPreference.userInfoJson = _userInfo.toJson();
  }

  Future<void> _clearDatabase() async {
    await _appDatabase.anchorDao.clear();
    await _appDatabase.orderDao.clear();
    await _appDatabase.chatConversationDao.clear();
    await _appDatabase.searchHistoryDao.clear();
    await _appDatabase.cardDao.clear();
  }

  Future<void> showTopupToAccountDialogIfNeeded({
    required CochatUserModel oldUser,
    required CochatUserModel newUser,
  }) async {
    // late int vipDays;
    // if (oldUser.vipDate > 0) {
    //   vipDays = (newUser.vipDate - oldUser.vipDate) ~/ (24 * 3600);
    // } else {
    //   final now = DateTime.now().millisecondsSinceEpoch / 1000;
    //   vipDays = (newUser.vipDate - now) ~/ (24 * 3600) + 1;
    // }
    final diamonds = newUser.mizuan - oldUser.mizuan;
    // final cardNum = newUser.cardNum - oldUser.cardNum;
    if (/*vipDays > 0 || */ diamonds > 0 /* || cardNum > 0*/) {
      VochatDialogUtil.showDialog(
        VochatTopupToAccountDialog(
          diamonds: diamonds,
          vipDays: 0, //vipDays,
          cardNum: 0, //cardNum,
        ),
      );
    }
  }
}
