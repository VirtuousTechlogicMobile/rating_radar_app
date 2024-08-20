import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../../../theme/theme_controller.dart';
import 'model/menu_data_model.dart';

class DrawerMenuController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isShowExpandedContent = false.obs;
  RxInt selectedMenuIndex = 0.obs;
  RxString userName = ''.obs;

  getUserName() async {
    String userId = await PreferencesManager.getUserId() ?? '';
    userName.value = await DatabaseHelper.instance.getUserName(uId: userId) ?? '';
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

  List<MenuDataModel> menuDataList = [
    MenuDataModel(prefixSvgIcon: SvgAssets.drawerDashboardIcon, menuName: 'dashboard'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.drawerAdsListIcon, menuName: 'ads_list'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.drawerWalletIcon, menuName: 'wallet'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.drawerReferralIcon, menuName: 'referral'.tr),
  ];

  List<MenuDataModel> endMenuDataList = [
    MenuDataModel(
      prefixSvgIcon: SvgAssets.settingsIcon,
      menuName: 'settings'.tr,
      isShowRightIcon: false,
      svgIconHeight: Dimens.twenty,
      svgIconWidth: Dimens.twenty,
    ),
    MenuDataModel(
      prefixSvgIcon: SvgAssets.drawerAdsListIcon,
      menuName: 'help'.tr,
      isShowRightIcon: false,
    ),
    MenuDataModel(
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
