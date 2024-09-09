import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_assets_util.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../../user_settings_menu_drawer/view/user_settings_menu_drawer_view.dart';

class UserMyAccountSettingScreen extends StatelessWidget {
  UserMyAccountSettingScreen({super.key});

  // final userWalletController = Get.find<UserWalletController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ThemeColorsUtil themeUtils;
  late ThemeAssetsUtil themeAssets;

  @override
  Widget build(BuildContext context) {
    themeUtils = ThemeColorsUtil(context);
    themeAssets = ThemeAssetsUtil(context);
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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: constraints.maxHeight,
                child: UserSettingsMenuDrawerView(),
              ).marginOnly(top: Dimens.twenty, left: Dimens.thirty, bottom: Dimens.forty),
              Expanded(
                child: Container(
                  // width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.fifteen, right: Dimens.twentyFour, bottom: Dimens.forty),
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
                              child: Padding(
                                padding: EdgeInsets.only(bottom: Dimens.ten),
                                child: CommonWidgets.autoSizeText(
                                  text: 'my_account'.tr,
                                  textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                  minFontSize: 16,
                                  maxFontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
