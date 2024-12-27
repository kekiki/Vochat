import 'package:get/get.dart';

enum ColiveMyBillsType {
  call,
  gift,
  sys,
  cash,
  count,
}

class ColiveMyBillsState {
  final currentTypeObs = ColiveMyBillsType.call.obs;
}
