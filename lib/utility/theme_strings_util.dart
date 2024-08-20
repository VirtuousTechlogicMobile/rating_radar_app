import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeStringsUtil {
  final bool isDarkTheme;
  ThemeStringsUtil(BuildContext context) : isDarkTheme = Theme.of(context).brightness == Brightness.dark;

  String get lightDarkModeValue {
    return isDarkTheme ? 'dark_mode'.tr : 'light_mode'.tr;
  }
}
