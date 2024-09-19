import 'dart:ui';

import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/custom_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../user_signup/model/user_signup_model.dart';

class UserPaymentComponents {
  static Widget userBankAccountCardLayout({required ThemeColorsUtil themeUtils, required UserBankData userBankData}) {
    return Container(
      width: Dimens.threeHundred,
      height: Dimens.fifty,
      padding: EdgeInsets.only(top: Dimens.eight, bottom: Dimens.eight, left: Dimens.fifteen, right: Dimens.eighteen),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.fifteen),
        border: Border.all(width: Dimens.one, color: themeUtils.primaryColorSwitch),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidgets.fromSvg(svgAsset: SvgAssets.axisBankIcon).marginOnly(right: Dimens.sevenTeen),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.autoSizeText(
                text: userBankData.bankName,
                textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                minFontSize: 10,
                maxFontSize: 18,
              ),
              CommonWidgets.autoSizeText(
                text: userBankData.accNumber,
                textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                minFontSize: 10,
                maxFontSize: 14,
              ).marginOnly(top: Dimens.one),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(Dimens.two),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorValues.romanColor,
            ),
            child: Icon(Icons.close, size: Dimens.thirteen, color: ColorValues.whiteColor),
          ),
        ],
      ),
    );
  }

  static void showAddAccountDialog({
    required BuildContext context,
    required Function() onAdd,
    required TextEditingController bankNameController,
    required TextEditingController ifscCodeController,
    required TextEditingController accNumberController,
    required TextEditingController accHolderNameController,
  }) {
    ValueNotifier<bool> isShowAccNumberVn = ValueNotifier(false);
    final themeUtils = ThemeColorsUtil(context);
    Get.dialog(
      barrierColor: ColorValues.transparent,
      Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - Dimens.eighty, // minus header height
          width: (MediaQuery.of(context).size.width - Dimens.threeHundredTwenty) - Dimens.twoHundredSeventy, // minus drawer width
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Positioned(
                left: Dimens.threeHundredTwenty + Dimens.twoHundredFifty,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height - Dimens.eighty,
                    width: MediaQuery.of(context).size.width - Dimens.threeHundredTwenty,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              AlertDialog(
                alignment: Alignment.center,
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.fifty)),
                elevation: 0,
                content: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: themeUtils.drawerBgWhiteSwitchColor,
                    borderRadius: BorderRadius.circular(Dimens.twenty),
                    boxShadow: [
                      BoxShadow(
                        color: ColorValues.blackColor.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  RouteManagement.goToBack();
                                },
                                child: CommonWidgets.fromSvg(
                                  svgAsset: SvgAssets.leftArrowIcon,
                                  height: Dimens.twentyTwo,
                                  boxFit: BoxFit.fill,
                                  color: themeUtils.whiteBlackSwitchColor,
                                ).marginOnly(left: Dimens.twentyFive),
                              ),
                            ),
                            Text(
                              'add_bank_account'.tr,
                              style: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            ).marginOnly(left: Dimens.twentyTwo, top: Dimens.five),
                          ],
                        ),
                        Text(
                          'enter_the_account_details'.tr,
                          style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                        ).marginOnly(top: Dimens.five, left: Dimens.sixty),
                        Text(
                          'bank_name'.tr,
                          style: AppStyles.style16SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                        ).marginOnly(top: Dimens.twentyTwo, bottom: Dimens.ten, left: Dimens.sixty),
                        CustomTextField(
                          controller: bankNameController,
                          contentPadding: EdgeInsets.symmetric(vertical: Dimens.nineteen, horizontal: Dimens.twentyFive),
                          maxLines: 1,
                          borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                          borderRadius: BorderRadius.circular(Dimens.nine),
                          hintText: 'bank_name'.tr,
                          textStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                          hintStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                          fillColor: themeUtils.drawerBgWhiteSwitchColor,
                        ).marginOnly(left: Dimens.sixty),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ifsc_code'.tr,
                                    style: AppStyles.style16SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                  ).marginOnly(top: Dimens.twentyFive, bottom: Dimens.ten, left: Dimens.sixty),
                                  CustomTextField(
                                    controller: ifscCodeController,
                                    contentPadding: EdgeInsets.symmetric(vertical: Dimens.nineteen, horizontal: Dimens.ten),
                                    maxLines: 1,
                                    borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                                    borderRadius: BorderRadius.circular(Dimens.nine),
                                    hintText: 'ifsc_code'.tr,
                                    textStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                                    hintStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                                    fillColor: themeUtils.drawerBgWhiteSwitchColor,
                                  ).marginOnly(left: Dimens.sixty),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'account_number'.tr,
                                    style: AppStyles.style16SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                  ).marginOnly(top: Dimens.twentyFive, bottom: Dimens.ten, left: Dimens.twenty),
                                  ValueListenableBuilder(
                                      valueListenable: isShowAccNumberVn,
                                      builder: (context, child, value) {
                                        return CustomTextField(
                                          controller: accNumberController,
                                          contentPadding: EdgeInsets.symmetric(vertical: Dimens.nineteen, horizontal: Dimens.twelve),
                                          maxLines: 1,
                                          borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                                          borderRadius: BorderRadius.circular(Dimens.nine),
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          hintText: 'account_number'.tr,
                                          textStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                                          hintStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              isShowAccNumberVn.value = !isShowAccNumberVn.value;
                                            },
                                            child: isShowAccNumberVn.value
                                                ? CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityIcon)
                                                : CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityOffIcon),
                                          ),
                                          obscureText: !isShowAccNumberVn.value,
                                          obscuringCharacter: '*',
                                          fillColor: themeUtils.drawerBgWhiteSwitchColor,
                                        ).marginOnly(left: Dimens.twenty);
                                      }),
                                ],
                              ),
                            ),
                            const Flexible(flex: 2, child: SizedBox.shrink()),
                          ],
                        ),
                        Text(
                          'account_holder_name'.tr,
                          style: AppStyles.style16SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                        ).marginOnly(top: Dimens.twentyTwo, bottom: Dimens.ten, left: Dimens.sixty),
                        CustomTextField(
                          controller: accHolderNameController,
                          contentPadding: EdgeInsets.symmetric(vertical: Dimens.nineteen, horizontal: Dimens.twentyFive),
                          maxLines: 1,
                          borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                          borderRadius: BorderRadius.circular(Dimens.nine),
                          hintText: 'account_holder_name'.tr,
                          textStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                          hintStyle: AppStyles.style14SemiLight.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                          fillColor: themeUtils.drawerBgWhiteSwitchColor,
                        ).marginOnly(left: Dimens.sixty),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Dimens.oneHundredSixty,
                              child: CustomButton(
                                btnText: 'cancel'.tr,
                                btnTextStyle: AppStyles.style13Normal.copyWith(color: themeUtils.blackWhiteSwitchColor),
                                borderRadius: BorderRadius.circular(Dimens.thirty),
                                contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten),
                                margin: EdgeInsets.only(top: Dimens.twentyOne, right: Dimens.seven),
                                isShowShadow: true,
                                onTap: () {
                                  RouteManagement.goToBack();
                                },
                              ),
                            ),
                            SizedBox(
                              width: Dimens.oneHundredSixty,
                              child: CustomButton(
                                btnText: 'add'.tr,
                                btnTextStyle: AppStyles.style13Normal.copyWith(color: themeUtils.blackWhiteSwitchColor),
                                borderRadius: BorderRadius.circular(Dimens.thirty),
                                contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten),
                                margin: EdgeInsets.only(top: Dimens.twentyOne, left: Dimens.seven),
                                isShowShadow: true,
                                onTap: () => onAdd(),
                              ),
                            ),
                          ],
                        ).marginOnly(left: Dimens.sixty),
                      ],
                    ).marginOnly(bottom: Dimens.twentyFive, top: Dimens.twenty, right: Dimens.sixty),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.linear,
      barrierDismissible: false,
    );
  }
}
