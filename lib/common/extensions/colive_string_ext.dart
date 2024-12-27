import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';

extension ColiveStringExt on String {
  String get md5 => crypto.md5.convert(utf8.encode(this)).toString();

  Size boundingSize(
    TextStyle style, {
    int maxLines = 2 ^ 31,
    double maxWidth = double.infinity,
  }) {
    TextPainter textPainter = TextPainter(
      maxLines: maxLines,
      text: TextSpan(
        text: this,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
