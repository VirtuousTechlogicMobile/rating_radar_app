import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_assets_util.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_theme_switch_button.dart';
import '../../../../constant/dimens.dart';
import '../user_logout_controller.dart';

class UserLogoutScreen extends StatelessWidget {
  final userLogoutController = Get.find<UserLogoutController>();
  UserLogoutScreen({super.key}) {
    userLogoutController.logoutUser();
  }
  late ThemeColorsUtil themeColorsUtil;
  late ThemeAssetsUtil themeAssetUtil;

  @override
  Widget build(BuildContext context) {
    themeColorsUtil = ThemeColorsUtil(context);
    themeAssetUtil = ThemeAssetsUtil(context);
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
          Align(
            alignment: Alignment.topCenter,
            child: logoutBoxLayout(context),
          ),

          /// switch theme button
          const Positioned(
            right: 0,
            bottom: 0,
            child: CustomThemeSwitchButton(),
          ),
        ],
      ),
    );
  }

  Widget logoutBoxLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.only(bottom: Dimens.forty, top: Dimens.eighty),
      decoration: BoxDecoration(
        color: themeColorsUtil.deepBlackWhiteSwitchColor,
        border: Border.all(color: themeColorsUtil.primaryColorSwitch, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: Dimens.fortyFour, top: Dimens.forty, left: Dimens.fortyFour),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidgets.fromSvg(svgAsset: themeAssetUtil.logoutSwitchImage),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.twentyFive, bottom: Dimens.five),
                  child: CommonWidgets.autoSizeRichText(
                    textSpans: [
                      TextSpan(
                        text: '${'you_are'.tr} ',
                        style: AppStyles.style21Normal.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                      ),
                      TextSpan(
                        text: 'logged_out'.tr,
                        style: AppStyles.style21Bold.copyWith(color: themeColorsUtil.primaryColorSwitch),
                      ),
                    ],
                    minFontSize: 15,
                    maxFontSize: 21,
                  ),
                ),
                CommonWidgets.autoSizeText(
                  text: 'thank_you_for_using_review_and_rating'.tr,
                  textStyle: AppStyles.style14Normal.copyWith(color: themeColorsUtil.whiteBlackSwitchColor.withOpacity(0.50)),
                  minFontSize: 10,
                  maxFontSize: 14,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Dimens.forty),
                  child: CustomButton(
                    btnText: 'sign_in'.tr,
                    buttonColor: themeColorsUtil.primaryColorSwitch,
                    margin: EdgeInsets.only(top: Dimens.forty, bottom: Dimens.forty),
                    onTap: () async {
                      RouteManagement.goToUserSignInScreen();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
