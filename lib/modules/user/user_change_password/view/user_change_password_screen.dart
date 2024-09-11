import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/modules/user/user_change_password/user_change_password_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/utility.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../../user_settings_menu_drawer/view/user_settings_menu_drawer_view.dart';

class UserChangePasswordScreen extends StatelessWidget {
  UserChangePasswordScreen({super.key});

  final userChangePasswordController = Get.find<UserChangePasswordController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeUtils = ThemeColorsUtil(context);
    return Scaffold(
      backgroundColor: themeUtils.screensBgSwitchColor,
      body: Row(
        children: [
          DrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                Expanded(child: screenMainLayout(themeUtils: themeUtils)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return HeaderView(
      isDashboardScreen: false,
      isAdsListScreen: false,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: UserSettingsMenuDrawerView(),
            ).marginOnly(top: Dimens.twenty, left: Dimens.thirty, bottom: Dimens.forty),
            Flexible(
              child: Container(
                width: constraints.maxWidth / 3,
                margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.fifteen, right: Dimens.twentyFour, bottom: Dimens.forty),
                padding: EdgeInsets.only(left: Dimens.twentyEight, right: Dimens.twentyEight, bottom: Dimens.ninety, top: Dimens.twentyOne),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.twentyTwo),
                  color: themeUtils.deepBlackWhiteSwitchColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 60,
                      spreadRadius: 0,
                      color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonWidgets.autoSizeText(
                      text: 'change_password'.tr,
                      textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                      minFontSize: 16,
                      maxFontSize: 24,
                    ).marginOnly(bottom: Dimens.twenty),

                    /// password fields
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonWidgets.autoSizeText(
                          text: 'enter_new_password'.tr,
                          textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                          minFontSize: 8,
                          maxFontSize: 14,
                        ).marginOnly(bottom: Dimens.nine),
                        Obx(
                          () => CustomTextField(
                            controller: userChangePasswordController.passwordController1,
                            borderRadius: BorderRadius.circular(Dimens.seven),
                            hintText: 'password'.tr,
                            maxLines: 1,
                            hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                            textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                            fillColor: ColorValues.transparent,
                            borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                            suffixIcon: InkWell(
                              onTap: () {
                                userChangePasswordController.isShowPassword1.value = !userChangePasswordController.isShowPassword1.value;
                              },
                              child: userChangePasswordController.isShowPassword1.value
                                  ? CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityIcon)
                                  : CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityOffIcon),
                            ),
                            obscureText: !userChangePasswordController.isShowPassword1.value,
                          ),
                        ),
                      ],
                    ).marginSymmetric(horizontal: Dimens.sevenTeen),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonWidgets.autoSizeText(
                          text: 're_enter_your_password'.tr,
                          textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                          minFontSize: 8,
                          maxFontSize: 14,
                        ).marginOnly(bottom: Dimens.nine),
                        Obx(
                          () => CustomTextField(
                            controller: userChangePasswordController.passwordController2,
                            borderRadius: BorderRadius.circular(Dimens.seven),
                            hintText: 'password'.tr,
                            maxLines: 1,
                            hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                            textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                            contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                            fillColor: ColorValues.transparent,
                            borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                            suffixIcon: InkWell(
                              onTap: () {
                                userChangePasswordController.isShowPassword2.value = !userChangePasswordController.isShowPassword2.value;
                              },
                              child: userChangePasswordController.isShowPassword2.value
                                  ? CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityIcon)
                                  : CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityOffIcon),
                            ),
                            obscureText: !userChangePasswordController.isShowPassword2.value,
                          ),
                        ),
                      ],
                    ).marginOnly(left: Dimens.sevenTeen, right: Dimens.sevenTeen, top: Dimens.fifteen),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomButton(
                            btnText: 'cancel'.tr,
                            onTap: () {
                              userChangePasswordController.passwordController1.clear();
                              userChangePasswordController.passwordController2.clear();
                            },
                            isShowShadow: true,
                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.eleven),
                            borderRadius: BorderRadius.circular(Dimens.thirty),
                            margin: EdgeInsets.only(right: Dimens.seven),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            btnText: 'change'.tr,
                            isShowShadow: true,
                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.eleven),
                            borderRadius: BorderRadius.circular(Dimens.thirty),
                            margin: EdgeInsets.only(left: Dimens.seven),
                            onTap: () async {
                              if (userChangePasswordController.passwordController1.text.trim().isEmpty) {
                                AppUtility.showSnackBar('please_enter_password'.tr);
                              } else if (userChangePasswordController.passwordController1.text.trim().length < 6) {
                                AppUtility.showSnackBar('password_must_be_at_least_6_characters'.tr);
                              } else if (userChangePasswordController.passwordController2.text.trim().isEmpty) {
                                AppUtility.showSnackBar('please_re_enter_password'.tr);
                              } else if (userChangePasswordController.passwordController1.text != userChangePasswordController.passwordController2.text) {
                                AppUtility.showSnackBar('passwords_do_not_match'.tr);
                              } else {
                                await userChangePasswordController.changeUserPassword();
                              }
                            },
                          ),
                        ),
                      ],
                    ).marginOnly(left: Dimens.sevenTeen, right: Dimens.sevenTeen, top: Dimens.fifteen),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
