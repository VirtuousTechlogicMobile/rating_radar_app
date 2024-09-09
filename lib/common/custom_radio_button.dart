import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';

import '../constant/dimens.dart';
import '../constant/styles.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final double? btnSize;
  final String labelText;
  final TextStyle? labelTextStyle;
  final EdgeInsets? labelPadding;

  const CustomRadioButton({
    super.key,
    required this.isSelected,
    this.btnSize,
    required this.labelText,
    this.labelTextStyle,
    this.labelPadding,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeColorsUtil themeUtils = ThemeColorsUtil(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          size: btnSize ?? Dimens.twenty,
          color: themeUtils.primaryColorSwitch,
        ),
        Padding(
          padding: labelPadding ?? EdgeInsets.only(left: Dimens.sixTeen),
          child: Text(
            labelText,
            style: labelTextStyle ??
                AppStyles.style16Normal
                    .copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
      ],
    );
  }
}
