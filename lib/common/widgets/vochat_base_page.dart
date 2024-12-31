import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VochatBasePage<T> extends GetView<T> {
  const VochatBasePage({super.key});

  @override
  Widget build(BuildContext context);
}
