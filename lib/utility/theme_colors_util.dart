import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ThemeColorsUtil {
  final bool isDarkTheme;
  ThemeColorsUtil(BuildContext context) : isDarkTheme = Theme.of(context).brightness == Brightness.dark;

  Color get darkGrayWhiteSwitchColor {
    return isDarkTheme ? ColorValues.darkGrayColor : ColorValues.whiteColor;
  }

  Color get interiorUpColor {
    return isDarkTheme ? ColorValues.lightBlackColor : ColorValues.primaryColorBlue;
  }

  Color get primaryColorSwitch {
    return isDarkTheme ? ColorValues.primaryColorYellow : ColorValues.primaryColorBlue;
  }

  Color get primaryLightColorSwitch {
    return isDarkTheme ? ColorValues.primaryColorLightYellow : ColorValues.primaryColorLightBlue;
  }

  Color get deepBlackWhiteSwitchColor {
    return isDarkTheme ? ColorValues.deepBlackColor : ColorValues.whiteColor;
  }

  Color get whiteBlackSwitchColor {
    return isDarkTheme ? ColorValues.whiteColor : ColorValues.blackColor;
  }

  Color get blackWhiteSwitchColor {
    return isDarkTheme ? ColorValues.blackColor : ColorValues.whiteColor;
  }

  Color get blackGreySwitchColor {
    return isDarkTheme ? ColorValues.whiteColor : ColorValues.lightGrayColor;
  }

  Color get deepBlackBlueSwitchColor {
    return isDarkTheme ? ColorValues.deepBlackColor : ColorValues.primaryColorBlue;
  }

  Color get blackPrimaryBlueSwitchColor {
    return isDarkTheme ? ColorValues.blackColor : ColorValues.primaryColorBlue;
  }

  Color get drawerBgWhiteSwitchColor {
    return isDarkTheme ? ColorValues.drawerBgColor : ColorValues.whiteColor;
  }

  Color get drawerShadowBlackSwitchColor {
    return isDarkTheme ? ColorValues.blackColor : ColorValues.drawerShadowColor;
  }

  Color get screensBgSwitchColor {
    return isDarkTheme ? ColorValues.lightBlackColor : ColorValues.ofWhiteColor;
  }

  Color get lightGrayC4SwitchColor {
    return isDarkTheme ? ColorValues.lightGrayC4Color.withOpacity(0.50) : ColorValues.lightGrayC4Color;
  }

  Color get whiteDarkCharcoalSwitchColor {
    return isDarkTheme ? ColorValues.whiteColor : ColorValues.darkCharcoalColor;
  }

  Color get darkGrayOfWhiteSwitchColor {
    return isDarkTheme ? ColorValues.darkGrayColor : ColorValues.ofWhiteColor;
  }

  Color get cardTextColor {
    return isDarkTheme ? ColorValues.whiteColor : ColorValues.cardTextColor;
  }

  Color get blackColorWithWhiteColor {
    return isDarkTheme ? ColorValues.primaryColorYellow : ColorValues.blackColorRecentText;
  }

  Color get boxShadowContainerColor {
    return isDarkTheme ? ColorValues.primaryColorYellow.withOpacity(0.15) : ColorValues.primaryColorBlue.withOpacity(0.15);
  }

  Color get fontColorBlackWhiteSwitchColor {
    return isDarkTheme ? ColorValues.whiteColor : ColorValues.fontColorBlack;
  }

  Color get dividerSwitchColor {
    return isDarkTheme ? ColorValues.dividerGreyColor.withOpacity(0.50) : ColorValues.dividerGreyColor;
  }

  Color get borderTableHoverColor {
    return isDarkTheme ? ColorValues.primaryColorYellow : ColorValues.blackColor;
  }

  Color get adsTextFieldBorderColor {
    return isDarkTheme ? ColorValues.primaryColorYellow : ColorValues.adsTextFieldBorderColor;
  }

  Color get midNightBlackWhiteSwitchColor {
    return isDarkTheme ? ColorValues.midNightBlack : ColorValues.whiteColor;
  }

  Color get darkGraySoftWhiteSwitchColor {
    return isDarkTheme ? ColorValues.darkGrayColor : ColorValues.softWhiteColor;
  }

  Color get commentViewAdColor {
    return isDarkTheme ? ColorValues.commentDarkColor : ColorValues.commentColor;
  }
}
