import 'package:flutter/material.dart';
import 'package:vochat/common/adapts/vochat_colors.dart';
import 'vochat_screen_adapt.dart';

abstract class VochatStyles {
  /// title font
  static const TextStyle _title = TextStyle(
    color: VochatColors.primaryTextColor,
    height: 1.5,
  );

  static final title10w500 =
      _title.copyWith(fontWeight: FontWeight.w500, fontSize: 10.pt);
  static final title12w500 =
      _title.copyWith(fontWeight: FontWeight.w500, fontSize: 12.pt);
  static final title12w700 =
      _title.copyWith(fontWeight: FontWeight.w700, fontSize: 12.pt);
  static final title14w600 =
      _title.copyWith(fontWeight: FontWeight.w600, fontSize: 14.pt);
  static final title16w600 =
      _title.copyWith(fontWeight: FontWeight.w600, fontSize: 16.pt);
  static final title16w700 =
      _title.copyWith(fontWeight: FontWeight.w700, fontSize: 16.pt);
  static final title18w700 =
      _title.copyWith(fontWeight: FontWeight.w700, fontSize: 18.pt);
  static final title22w700 =
      _title.copyWith(fontWeight: FontWeight.w700, fontSize: 22.pt);
  static final title26w600 =
      _title.copyWith(fontWeight: FontWeight.w600, fontSize: 26.pt);

  /// body font
  static const TextStyle _body = TextStyle(
    color: VochatColors.primaryTextColor,
    height: 1.4,
  );

  static final body10w400 =
      _body.copyWith(fontWeight: FontWeight.w400, fontSize: 10.pt);
  static final body12w400 =
      _body.copyWith(fontWeight: FontWeight.w400, fontSize: 12.pt);
  static final body14w400 =
      _body.copyWith(fontWeight: FontWeight.w400, fontSize: 14.pt);
  static final body14w600 =
      _body.copyWith(fontWeight: FontWeight.w600, fontSize: 14.pt);
  static final body16w400 =
      _body.copyWith(fontWeight: FontWeight.w400, fontSize: 16.pt);
  static final body20w400 =
      _body.copyWith(fontWeight: FontWeight.w700, fontSize: 18.pt);
}
