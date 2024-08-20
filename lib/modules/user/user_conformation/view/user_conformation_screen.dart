import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_theme_switch_button.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../../../utility/utility.dart';
import '../user_conformation_controller.dart';

class UserConformationScreen extends StatefulWidget {
  String email;

  UserConformationScreen({super.key, required this.email});

  @override
  State<UserConformationScreen> createState() => _UserConformationScreenState();
}

class _UserConformationScreenState extends State<UserConformationScreen> with SingleTickerProviderStateMixin {
  final userConformationController = Get.find<UserConformationController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userConformationController.startTimer();
    userConformationController.animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeColorsUtil = ThemeColorsUtil(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                color: themeColorsUtil.interiorUpColor,
              ),
              Expanded(
                child: Container(
                  color: themeColorsUtil.darkGrayWhiteSwitchColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// signup
              Padding(
                padding: EdgeInsets.only(right: Dimens.eighteen),
                child: conformationBoxLayout(context, themeColorsUtil),
              ),

              /// switch theme button
              const CustomThemeSwitchButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget conformationBoxLayout(BuildContext context, ThemeColorsUtil themeColorsUtil) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.only(bottom: Dimens.forty, top: Dimens.eighty),
      decoration: BoxDecoration(
        color: themeColorsUtil.deepBlackWhiteSwitchColor,
        border: Border.all(color: themeColorsUtil.primaryColorSwitch, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: Dimens.fortyFour, top: Dimens.forty, left: Dimens.fortyFour),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CommonWidgets.autoSizeRichText(
                textSpans: [
                  TextSpan(
                    text: 'welcome_to'.tr,
                    style: AppStyles.style21Normal.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                  ),
                  TextSpan(
                    text: " ${'ratings'.tr}",
                    style: AppStyles.style21Bold.copyWith(color: themeColorsUtil.primaryColorSwitch),
                  ),
                ],
                minFontSize: 10,
                maxFontSize: 21,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: Dimens.forty),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Dimens.twentyFive),
                      child: CommonWidgets.autoSizeText(
                        text: 'confirm_your_email_address'.tr,
                        textStyle: AppStyles.style24Bold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                        minFontSize: 14,
                        maxFontSize: 24,
                      ),
                    ),
                    CommonWidgets.autoSizeText(
                      text: 'we_sent_a_confirmation_email_to'.tr,
                      textStyle: AppStyles.style18Bold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor.withOpacity(0.50)),
                      minFontSize: 8,
                      maxFontSize: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.ten),
                      child: CommonWidgets.autoSizeText(
                        text: widget.email,
                        textStyle: AppStyles.style18Bold.copyWith(color: themeColorsUtil.primaryColorSwitch.withOpacity(0.50)),
                        minFontSize: 8,
                        maxFontSize: 18,
                      ),
                    ),
                    CommonWidgets.autoSizeText(
                      text: 'check_your_email_and_click_on_the_confirmation_link_to_continue'.tr,
                      textStyle: AppStyles.style18Bold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor.withOpacity(0.50)),
                      minFontSize: 8,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      maxFontSize: 18,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    CommonWidgets.autoSizeText(
                      text: 'resend_link'.tr,
                      textStyle: AppStyles.style14SemiBold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                      minFontSize: 8,
                      maxFontSize: 14,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimens.four, bottom: Dimens.ten),
                      child: Obx(
                        () => CommonWidgets.autoSizeText(
                          text: "00:${userConformationController.start.value.toString().padLeft(2, '0')}",
                          textStyle: AppStyles.style14SemiBold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor.withOpacity(0.50)),
                          minFontSize: 8,
                          maxFontSize: 14,
                        ),
                      ),
                    ),
                    Obx(
                      () => CustomButton(
                        btnText: 'resend_email'.tr,
                        isShowLoading: userConformationController.isShowLoadingOnButton.value,
                        buttonColor: userConformationController.start.value == 0 ? themeColorsUtil.primaryColorSwitch : themeColorsUtil.primaryLightColorSwitch,
                        onTap: () async {
                          if (userConformationController.start.value == 0) {
                            await userConformationController.resendEmailLink();
                            AppUtility.showSnackBar('confirmation_link_sent'.tr);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimens.thirty),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              String logoutStatus = await userConformationController.onLogout();
                              if (logoutStatus == CustomStatus.success) {
                                RouteManagement.goToUserSignInView();
                              } else {
                                AppUtility.showSnackBar('failed_to_logout'.tr);
                              }
                            },
                            child: Container(
                              height: Dimens.twentyEight,
                              width: Dimens.twentyEight,
                              decoration: BoxDecoration(
                                border: Border.all(color: themeColorsUtil.whiteBlackSwitchColor, width: 1),
                                color: ColorValues.transparent,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: CommonWidgets.fromSvg(
                                svgAsset: SvgAssets.drawerLogoutIcon,
                                color: themeColorsUtil.whiteBlackSwitchColor,
                                width: Dimens.fifteen,
                                height: Dimens.fourteen,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimens.thirteen),
                            child: InkWell(
                              onTap: () async {
                                bool isUserVerified = await userConformationController.onRefresh();
                                if (isUserVerified) {
                                  RouteManagement.goToUserHomePageView();
                                }
                              },
                              child: Container(
                                height: Dimens.twentyEight,
                                width: Dimens.twentyEight,
                                decoration: BoxDecoration(
                                  border: Border.all(color: themeColorsUtil.whiteBlackSwitchColor, width: 1),
                                  color: ColorValues.transparent,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: RotationTransition(
                                  turns: Tween(begin: 0.0, end: 1.0).animate(userConformationController.animationController),
                                  child: CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.refreshIcon,
                                    color: themeColorsUtil.whiteBlackSwitchColor,
                                    width: Dimens.fifteen,
                                    height: Dimens.thirteen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
