import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/dimens.dart';
import '../constant/styles.dart';

class CustomTextField extends StatelessWidget {
  String? hintText;
  TextStyle? hintStyle;
  TextEditingController controller;
  TextInputType? inputType;
  FocusNode? focusNode;
  EdgeInsetsGeometry? contentPadding;
  bool isReadOnly;
  TextStyle? textStyle;
  Function(String value)? onChange;
  Widget? prefixIcon;
  int? length;
  int? maxLines;
  bool? autofocus;
  bool isShowError;
  String errMsg;
  Color? fillColor;
  Widget? suffixIcon;
  Function(PointerDownEvent)? onTapOutside;
  void Function()? onTap;
  bool? obscureText;
  TextAlign? textAlign;
  BorderRadius? borderRadius;
  BorderSide? borderSide;
  List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.focusNode,
    this.hintStyle,
    this.inputType,
    this.isReadOnly = false,
    this.length,
    this.textStyle,
    this.maxLines,
    this.onChange,
    this.prefixIcon,
    this.contentPadding,
    this.autofocus,
    this.isShowError = false,
    this.errMsg = '',
    this.fillColor,
    this.suffixIcon,
    this.onTap,
    this.obscureText,
    this.onTapOutside,
    this.textAlign,
    this.borderRadius,
    this.borderSide,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ThemeColorsUtil(context);
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      expands: false,
      controller: controller,
      inputFormatters: inputFormatters,
      readOnly: isReadOnly,
      autofocus: autofocus ?? false,
      style: textStyle ??
          AppStyles.style14SemiLight
              .copyWith(color: themeColors.blackColorWithWhiteColor),
      maxLength: length,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      showCursor: !isReadOnly,
      cursorColor: themeColors.blackColorWithWhiteColor,
      onTapOutside: onTapOutside,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: contentPadding ??
            EdgeInsets.only(
                top: Dimens.nineteen,
                bottom: Dimens.nineteen,
                left: Dimens.twenty),
        isDense: true,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: Dimens.ten),
          child: suffixIcon,
        ),
        prefixIcon: prefixIcon,
        suffixIconConstraints: BoxConstraints(
            maxWidth: Dimens.thirty,
            maxHeight: Dimens.thirty,
            minWidth: Dimens.fifteen,
            minHeight: Dimens.fifteen),
        filled: true,
        fillColor: fillColor,
        hintText: hintText ?? '',
        hintStyle:
            WidgetStateTextStyle.resolveWith((Set<MaterialState> states) {
          if (states.contains(WidgetState.focused)) {
            return hintStyle ??
                AppStyles.style14SemiLight.copyWith(
                    color: themeColors.primaryColorSwitch.withOpacity(0.80));
          }
          return hintStyle ??
              AppStyles.style14SemiLight
                  .copyWith(color: ColorValues.lightGrayColor);
        }),
        // focusColor: themeColors.blackBlueSwitchColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(9.0),
          borderSide: borderSide ??
              BorderSide(color: themeColors.primaryColorSwitch, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(9.0),
          borderSide: borderSide ??
              const BorderSide(color: ColorValues.borderGrayColor, width: 1),
        ),
      ),
      focusNode: focusNode,
      onTap: onTap,
      onChanged: (value) => (onChange != null) ? onChange!(value) : null,
    );
  }
}
