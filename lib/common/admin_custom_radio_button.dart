import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';

import '../constant/dimens.dart';
import '../constant/styles.dart';

class AdminCustomRadioButton extends StatelessWidget {
  final ThemeColorsUtil themeColorsUtil;
  final ValueNotifier<String> controller;
  final String status;
  final double? btnSize;
  final String labelText;
  final TextStyle? labelTextStyle;
  final EdgeInsets? labelPadding;
  final VoidCallback? onTap; // Add onTap callback

  const AdminCustomRadioButton({
    super.key,
    required this.themeColorsUtil,
    required this.controller,
    required this.status,
    this.btnSize,
    required this.labelText,
    this.labelTextStyle,
    this.labelPadding,
    this.onTap, // Include onTap in constructor
  });

  @override
  Widget build(BuildContext context) {
    final ThemeColorsUtil themeUtils = ThemeColorsUtil(context);
    return ValueListenableBuilder<String>(
      valueListenable: controller,
      builder: (context, currentStatus, child) {
        return GestureDetector(
          onTap: () {
            controller.value =
                status; // Update the controller with the new status
            if (onTap != null) {
              onTap!(); // Trigger additional onTap logic
            }
          }, // Use the onTap callback
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                currentStatus == status
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
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
          ),
        );
      },
    );
  }
}
