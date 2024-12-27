import 'dart:async';

import 'package:get/get.dart';
import 'package:colive/common/utils/colive_loading_util.dart';
import 'package:colive/services/widgets/dialogs/colive_dialog_util.dart';
import 'package:colive/services/widgets/dialogs/colive_topup_to_account_dialog.dart';
import 'package:colive/services/extensions/colive_api_response_ext.dart';

import '../../common/preference/colive_preference.dart';
import '../extensions/colive_preference_ext.dart';
import '../api/colive_api_client.dart';
import '../database/colive_database.dart';
import '../models/colive_api_response.dart';
import '../models/colive_card_base_model.dart';
import '../models/colive_login_model.dart';
import '../repositories/colive_card_repository.dart';
import '../routes/colive_routes.dart';

class ColiveProfileManager {
  bool _isLogout = false;
  ColiveProfileManager._internal();

  static ColiveProfileManager? _instance;
  static ColiveProfileManager get instance =>
      _instance ??= ColiveProfileManager._internal();

  final List<StreamSubscription> subsriptions = [];

  final _apiClient = Get.find<ColiveApiClient>();
  final _appDatabase = Get.find<ColiveDatabase>();

  final _cardRepository = Get.find<ColiveCardRepository>();
  bool _hasFreeCallCard = false;
  List<ColiveCardItemModel>? _cardList;

  final StreamController<ColiveLoginModelUser> _streamController =
      StreamController.broadcast();
  ColiveLoginModelUser _userInfo =
      ColiveLoginModelUser.fromJson(ColiveAppPreferenceExt.userInfoJson);

  ColiveLoginModelUser get userInfo => _userInfo;
  Stream<ColiveLoginModelUser> get profileStream => _streamController.stream;

  List<ColiveCardItemModel> get cardList => _cardList ?? [];
  bool get hasFreeCallCard => _hasFreeCallCard;

  Future<void> login(ColiveLoginModel loginModel) async {
    if (loginModel.user!.id != _userInfo.id) {
      await _clearDatabase();
    }
    _isLogout = false;
    ColiveAppPreferenceExt.apiToken = loginModel.token;
    ColiveAppPreferenceExt.userId = loginModel.user!.id.toString();
    updateLocalInfo(loginModel.user!);
    Get.offAllNamed(ColiveRoutes.home);
  }

  Future<void> logout() async {
    if (_isLogout) return;
    _isLogout = true;
    ColiveAppPreferenceExt.apiToken = "";
    ColiveAppPreferenceExt.userId = "";
    _streamController.close();
    _removeListener();
    _instance = null;
    Get.offAllNamed(ColiveRoutes.login);
  }

  Future<void> deleteAccount() async {
    ColiveLoadingUtil.show();
    final result = await _apiClient.deleteAccount().response;
    if (result.isSuccess) {
      await ColiveAppPreference.clear();
      await _clearDatabase();
      ColiveLoadingUtil.dismiss();
      logout();
    } else {
      ColiveLoadingUtil.dismiss();
      ColiveLoadingUtil.showToast(result.msg);
    }
  }

  Future<ColiveApiResponse<ColiveLoginModelUser>> fetchProfile() async {
    final result = await _apiClient.fetchUserInfo().response;
    final data = result.data;
    if (result.isSuccess && data != null) {
      _isLogout = false;
      updateLocalInfo(data, true);
    }
    return result;
  }

  Future<void> updateDiamondsAndVipDate(int diamonds, int vipDate) async {
    if (diamonds != _userInfo.diamonds || vipDate != _userInfo.vipDate) {
      final user = _userInfo.copyWith(diamonds: diamonds, vipDate: vipDate);
      await updateLocalInfo(user, true);
    }
  }

  Future<void> updateLocalInfo(ColiveLoginModelUser userInfo,
      [bool isEvent = false]) async {
    showTopupToAccountDialogIfNeeded(oldUser: _userInfo, newUser: userInfo);
    _userInfo = userInfo;
    if (isEvent) {
      _streamController.add(userInfo);
      _addListener();
      _cardRepository.fetchCardList();
    }
    ColiveAppPreferenceExt.userInfoJson = _userInfo.toJson();
  }

  Future<void> _clearDatabase() async {
    await _appDatabase.anchorDao.clear();
    await _appDatabase.orderDao.clear();
    await _appDatabase.momentDao.clear();
    await _appDatabase.chatConversationDao.clear();
    await _appDatabase.searchHistoryDao.clear();
    await _appDatabase.cardDao.clear();
  }

  Future<void> showTopupToAccountDialogIfNeeded({
    required ColiveLoginModelUser oldUser,
    required ColiveLoginModelUser newUser,
  }) async {
    late int vipDays;
    if (oldUser.vipDate > 0) {
      vipDays = (newUser.vipDate - oldUser.vipDate) ~/ (24 * 3600);
    } else {
      final now = DateTime.now().millisecondsSinceEpoch / 1000;
      vipDays = (newUser.vipDate - now) ~/ (24 * 3600) + 1;
    }
    final diamonds = newUser.diamonds - oldUser.diamonds;
    // final cardNum = newUser.cardNum - oldUser.cardNum;
    if (vipDays > 0 || diamonds > 0 /* || cardNum > 0*/) {
      ColiveDialogUtil.showDialog(
        ColiveTopupToAccountDialog(
          diamonds: diamonds,
          vipDays: vipDays,
          cardNum: 0, //cardNum,
        ),
      );
    }
  }

  void _addListener() {
    _removeListener();
    subsriptions.add(_cardRepository.getCardList().listen((list) {
      if (list == null) return;
      if (_cardList == null) {
        _cardList = list;
        _hasFreeCallCard = list.any((element) => element.isFreeCallCard);
        return;
      }
      if (list.length > _cardList!.length) {
        ColiveDialogUtil.showDialog(
          ColiveTopupToAccountDialog(
            diamonds: 0,
            vipDays: 0,
            cardNum: list.length - _cardList!.length,
          ),
        );
      }
      _cardList = list;
      _hasFreeCallCard = list.any((element) => element.isFreeCallCard);
    }));
  }

  void _removeListener() {
    for (var element in subsriptions) {
      element.cancel();
    }
    subsriptions.clear();
  }
}
