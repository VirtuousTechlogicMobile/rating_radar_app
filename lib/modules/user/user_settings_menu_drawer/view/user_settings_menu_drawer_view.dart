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
  final settingsDrawerController = Get.find<UserSettingsMenuDrawerController>();

  UserSettingsMenuDrawerView({super.key}) {
    settingsDrawerController.getDrawerIndex();
  }

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
            maxFontSize: 28,
          ).marginOnly(bottom: Dimens.thirtyFive, left: Dimens.thirtyFive),
        ),
        ...List.generate(
          settingsDrawerController.menuDataList.length,
          (index) {
            return Obx(
              () => UserSettingsMenuDrawerComponent(
                menuDataModel: settingsDrawerController.menuDataList[index],
                isSelected: index == settingsDrawerController.selectedMenuIndex.value,
                onSelectMenuItem: (selectedMenu) async {
                  settingsDrawerController.setDrawerIndex(settingsDrawerController.menuDataList.indexOf(selectedMenu));
                  settingsDrawerController.selectedMenuIndex.value = settingsDrawerController.menuDataList.indexOf(selectedMenu);
                  if (settingsDrawerController.selectedMenuIndex.value == 0) {
                    RouteManagement.goToUserMyAccountSettingScreen();
                  } else if (settingsDrawerController.selectedMenuIndex.value == 1) {
                    // RouteManagement.goToUserChangePasswordScreen();
                  } else if (settingsDrawerController.selectedMenuIndex.value == 2) {
                    RouteManagement.goToUserChangePasswordScreen();
                  } else {
                    RouteManagement.goToUserDeleteAccountScreen();
                  }
                },
              ).marginOnly(bottom: 16),
            );
          },
        ),
      ],
    );
  }
}
