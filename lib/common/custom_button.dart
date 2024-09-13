import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';

import '../constant/dimens.dart';
import '../constant/styles.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final EdgeInsetsGeometry? margin;
  final bool isShowLoading;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets? contentPadding;
  final Color? buttonColor;
  final Function()? onTap;
  final bool? isShowShadow;
  final Color? btnTextColor;

  const CustomButton(
      {super.key,
      required this.btnText,
      this.margin,
      this.onTap,
      this.isShowLoading = false,
      this.buttonColor,
      this.borderRadius,
      this.isShowShadow = false,
      this.contentPadding,
      this.btnTextColor});

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? themeUtils.primaryColorSwitch,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          boxShadow: isShowShadow == true
              ? [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 19,
                    color: ColorValues.blackColor.withOpacity(0.30),
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        margin: margin ?? EdgeInsets.zero,
        padding: !isShowLoading ? contentPadding ?? EdgeInsets.symmetric(vertical: Dimens.fifteen) : EdgeInsets.symmetric(vertical: Dimens.ten),
        child: !isShowLoading
            ? CommonWidgets.autoSizeText(
                text: btnText,
                textStyle: AppStyles.style16Normal.copyWith(fontWeight: FontWeight.w500, color: btnTextColor ?? ColorValues.whiteColor),
                minFontSize: 10,
                maxFontSize: 16,
                maxLines: 1,
                textAlign: TextAlign.center,
              )
            : SizedBox(
                width: Dimens.twentyFive,
                height: Dimens.twentyFive,
                child: const CircularProgressIndicator(
                  color: ColorValues.whiteColor,
                ),
              ),
      ),
    );
  }
}
