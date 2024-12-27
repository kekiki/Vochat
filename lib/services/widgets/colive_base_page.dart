import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ColiveBasePage<T> extends GetView<T> {
  const ColiveBasePage({super.key});

  @override
  Widget build(BuildContext context);
}
