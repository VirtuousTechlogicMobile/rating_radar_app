import 'package:RatingRadar_app/constant/assets.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../constant/dimens.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../../../theme/theme_controller.dart';
import 'model/admin_menu_data_model.dart';

class AdminDrawerMenuController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isShowExpandedContent = false.obs;
  RxInt selectedMenuIndex = 0.obs;
  RxString email = ''.obs;

  getUserEmail() async {
    email.value = await DatabaseHelper.instance.getCurrentAdminEmail();
  }

  getAdminDrawerIndex() async {
    selectedMenuIndex.value = await PreferencesManager.getAdminDrawerIndex();
  }

  setAdminDrawerIndex(int index) async {
    await PreferencesManager.setAdminDrawerIndex(index: index);
  }

  void toggleDashboardProfileMenu() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      animationController.forward();
      isShowExpandedContent.value = true;
    } else {
      animationController.reverse();
      Future.delayed(const Duration(milliseconds: 150)).then(
        (value) {
          isShowExpandedContent.value = false;
        },
      );
    }
  }

  late AnimationController animationController;
  late Animation<double> animation;

  List<AdminMenuDataModel> adminMenuDataList = [
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerDashboardIcon, menuName: 'dashboard'.tr),
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerAdsListIcon, menuName: 'ads_list'.tr),
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerWalletIcon, menuName: 'wallet_user'.tr),
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerUserIcon, menuName: 'users'.tr),
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerCompanyIcon, menuName: 'compnays'.tr),
    AdminMenuDataModel(
        prefixSvgIcon: SvgAssets.drawerPaymentsIcon, menuName: 'payments'.tr),
  ];

  List<AdminMenuDataModel> adminEndMenuDataList = [
    AdminMenuDataModel(
      prefixSvgIcon: SvgAssets.settingsIcon,
      menuName: 'settings'.tr,
      isShowRightIcon: false,
      svgIconHeight: Dimens.twenty,
      svgIconWidth: Dimens.twenty,
    ),
    AdminMenuDataModel(
      prefixSvgIcon: SvgAssets.drawerAdsListIcon,
      menuName: 'help'.tr,
      isShowRightIcon: false,
    ),
    AdminMenuDataModel(
      prefixSvgIcon: SvgAssets.drawerWalletIcon,
      menuName: 'logout'.tr,
      isShowRightIcon: false,
    ),
  ];
  changeTheme() {
    AppThemeController.find.setThemeMode(
      AppThemeController.find.themeMode == kDarkMode ? 'light' : 'dark',
    );
  }
}
