import 'package:flutter/material.dart';

class ColiveSettingItem {
  final String title;
  final VoidCallback onTap;

  ColiveSettingItem(this.title, this.onTap);
}

class ColiveSettingsState {
  List<ColiveSettingItem> dataList = [];
}
