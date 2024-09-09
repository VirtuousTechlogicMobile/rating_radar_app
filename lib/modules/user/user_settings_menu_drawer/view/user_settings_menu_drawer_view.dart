import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/modules/user/user_settings_menu_drawer/user_settings_menu_drawer_controller.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../utility/theme_colors_util.dart';
import '../components/user_settings_menu_drawer_component.dart';

class UserSettingsMenuDrawerView extends StatelessWidget {
  UserSettingsMenuDrawerView({super.key});

  final drawerController = Get.find<UserSettingsMenuDrawerController>();

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Hero(
      tag: 'settings-drawer',
      child: Material(
        color: ColorValues.transparent,
        child: Container(
          width: Dimens.twoHundredFifty,
          padding: EdgeInsets.only(top: Dimens.thirty, right: Dimens.thirteen, left: Dimens.thirteen),
          decoration: BoxDecoration(
            color: themeUtils.drawerBgWhiteSwitchColor,
            borderRadius: BorderRadius.circular(Dimens.thirty),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 10), blurRadius: 60, spreadRadius: 0, color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50)),
            ],
          ),
          child: menuList(themeUtils),
        ),
      ),
    );
  }

  Widget menuList(ThemeColorsUtil themeUtils) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: CommonWidgets.autoSizeText(
            text: 'settings'.tr,
            textStyle: AppStyles.style28Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
            minFontSize: 15,
            maxFontSize: 24,
          ).marginOnly(bottom: Dimens.thirtyFive, left: Dimens.thirtyFive),
        ),
        ...List.generate(
          drawerController.menuDataList.length,
          (index) {
            return Obx(
              () => UserSettingsMenuDrawerComponent(
                menuDataModel: drawerController.menuDataList[index],
                isSelected: index == drawerController.selectedMenuIndex.value,
                onSelectMenuItem: (selectedMenu) async {
                  drawerController.setDrawerIndex(drawerController.menuDataList.indexOf(selectedMenu));
                  drawerController.selectedMenuIndex.value = drawerController.menuDataList.indexOf(selectedMenu);
                  /*if (drawerController.selectedMenuIndex.value == 0) {
                    RouteManagement.goToUserHomePageView();
                  } else if (drawerController.selectedMenuIndex.value == 1) {
                    RouteManagement.goToUserAdsListMenuView();
                  } else if (drawerController.selectedMenuIndex.value == 2) {
                    RouteManagement.goToUserWalletScreenView();
                  } else {
                    // RouteManagement.goToUserSignInView();
                  }*/
                },
              ).marginOnly(bottom: 16),
            );
          },
        ),
      ],
    );
  }
}
