import 'package:RatingRadar_app/constant/assets.dart';
import 'package:flutter/material.dart';

class ThemeAssetsUtil {
  final bool isDarkTheme;
  ThemeAssetsUtil(BuildContext context) : isDarkTheme = Theme.of(context).brightness == Brightness.dark;

  String get themeButton {
    return isDarkTheme ? SvgAssets.darkBrightnessIcon : SvgAssets.lightBrightnessIcon;
  }

  String get themeSwitchSmallButton {
    return isDarkTheme ? SvgAssets.darkThemeSmallSwitchIcon : SvgAssets.lightThemeSmallSwitchIcon;
  }
}
