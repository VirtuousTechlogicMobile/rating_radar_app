import 'package:RatingRadar_app/modules/user/user_referral/user_referral_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
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
      print("mansi : ${userReferralController.widgetWidth}");
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
                            ).marginOnly(bottom: Dimens.thirty),
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
