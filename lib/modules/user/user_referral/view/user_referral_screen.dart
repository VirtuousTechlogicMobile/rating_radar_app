import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/modules/user/user_referral/user_referral_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../helper/validators.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';

class UserReferralScreen extends StatefulWidget {
  const UserReferralScreen({super.key});

  @override
  State<UserReferralScreen> createState() => _UserReferralScreenState();
}

class _UserReferralScreenState extends State<UserReferralScreen> {
  final userReferralController = Get.find<UserReferralController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userReferralController.getTextWidth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
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
                screenMainLayout(themeUtils: themeUtils),
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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.twentyFour, right: Dimens.twentyFour, bottom: Dimens.forty),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.thirty),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.thirty),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.forty),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimens.twentyEight),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonWidgets.autoSizeText(
                              text: 'referral'.tr,
                              textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 16,
                              maxFontSize: 24,
                            ).marginOnly(bottom: Dimens.ten),
                            CommonWidgets.autoSizeText(
                              text: 'get_best_rewards'.tr,
                              textStyle: AppStyles.style16Normal.copyWith(color: themeUtils.primaryColorSwitch),
                              minFontSize: 10,
                              maxFontSize: 16,
                            ).marginOnly(bottom: Dimens.fifteen),
                            CommonWidgets.autoSizeText(
                              key: userReferralController.textKey,
                              text: 'refer_a_friends_and_you_get_rs100'.tr,
                              textStyle: AppStyles.style42SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 32,
                              maxFontSize: 42,
                            ),
                            Obx(
                              () => Container(
                                width: userReferralController.widgetWidth.value,
                                margin: EdgeInsets.only(top: Dimens.thirty),
                                decoration: BoxDecoration(
                                  border: Border.all(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.30), width: 1),
                                  borderRadius: BorderRadius.circular(Dimens.thirty),
                                ),
                                padding: EdgeInsets.only(top: Dimens.twentyEight, bottom: Dimens.thirtyEight, right: Dimens.thirtySix, left: Dimens.thirtySix),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonWidgets.autoSizeText(
                                      text: 'copy_and_share_link'.tr,
                                      textStyle: AppStyles.style28SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 18,
                                      maxFontSize: 28,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Obx(
                                                () => SelectionArea(
                                                  child: CommonWidgets.autoSizeText(
                                                    text: AppUtility.generateReferralLink(uId: userReferralController.userId.value),
                                                    textStyle: AppStyles.style21SemiBold.copyWith(
                                                      color: themeUtils.whiteBlackSwitchColor.withOpacity(0.70),
                                                    ),
                                                    minFontSize: 10,
                                                    maxFontSize: 21,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                                thickness: 1.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.oneHundredThirty,
                                          child: CustomButton(
                                            btnText: 'copy_link'.tr,
                                            margin: EdgeInsets.only(left: Dimens.thirty),
                                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.twelve),
                                            borderRadius: BorderRadius.circular(Dimens.hundred),
                                            onTap: () {
                                              /// copy link
                                              userReferralController.selectText(AppUtility.generateReferralLink(uId: userReferralController.userId.value));
                                              AppUtility.showSnackBar('link_copied'.tr);
                                            },
                                          ),
                                        ),
                                      ],
                                    ).marginOnly(top: Dimens.thirtyEight),
                                    CommonWidgets.autoSizeText(
                                      text: 'invite_by_email'.tr,
                                      textStyle: AppStyles.style28SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 18,
                                      maxFontSize: 28,
                                    ).marginOnly(top: Dimens.thirtyNine),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            controller: userReferralController.emailController,
                                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.fourteen, horizontal: Dimens.twentyTwo),
                                            maxLines: 1,
                                            borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                            borderRadius: BorderRadius.circular(Dimens.thirty),
                                            hintText: 'enter_email'.tr,
                                            hintStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                                            fillColor: themeUtils.drawerBgWhiteSwitchColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.oneHundredThirty,
                                          child: CustomButton(
                                            btnText: 'send'.tr,
                                            margin: EdgeInsets.only(left: Dimens.thirty),
                                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.twelve),
                                            borderRadius: BorderRadius.circular(Dimens.hundred),
                                            onTap: () async {
                                              if (userReferralController.emailController.text.trim().isEmpty) {
                                                AppUtility.showSnackBar('please_enter_email'.tr);
                                              } else if (userReferralController.emailController.text.trim().isNotEmpty &&
                                                  !Validators.isValidEmail(userReferralController.emailController.text)) {
                                                AppUtility.showSnackBar('please_enter_valid_email'.tr);
                                              } else {
                                                await userReferralController.sendEmail(
                                                  receiverEmail: userReferralController.emailController.text,
                                                  referralLink: AppUtility.generateReferralLink(uId: userReferralController.userId.value),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ).marginOnly(top: Dimens.twentySix),
                                  ],
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
            ),
          );
        },
      ),
    );
  }
}
