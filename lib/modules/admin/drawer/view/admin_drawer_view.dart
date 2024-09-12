import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../utility/theme_assets_util.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../../../utility/theme_strings_util.dart';
import '../admin_drawer_controller.dart';
import '../components/admin_drawer_menu_component.dart';

class AdminDrawerView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminDrawerView({super.key, required this.scaffoldKey});

  @override
  State<AdminDrawerView> createState() => _AdminDrawerViewState();
}

class _AdminDrawerViewState extends State<AdminDrawerView> with SingleTickerProviderStateMixin {
  final adminDrawerController = Get.find<AdminDrawerMenuController>();

  @override
  void initState() {
    super.initState();
    adminDrawerController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    );
    adminDrawerController.animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: adminDrawerController.animationController, curve: Curves.bounceIn),
    );
    adminDrawerController.getUserEmail();
    adminDrawerController.getAdminDrawerIndex();
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Hero(
      tag: 'adminDrawer',
      child: Material(
        color: ColorValues.transparent,
        child: Container(
          width: Dimens.threeHundredSix,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: Dimens.thirty, right: Dimens.twentyEight, left: Dimens.twentyEight),
          decoration: BoxDecoration(
            color: themeUtils.drawerBgWhiteSwitchColor,
            boxShadow: [
              BoxShadow(offset: const Offset(0, 10), blurRadius: 60, spreadRadius: 0, color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50)),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: Dimens.sixtyFive + Dimens.thirtyFour,
                left: 0,
                right: 0,
                child: adminMenuList(adminDrawerController: adminDrawerController),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: adminEndMenuList(adminDrawerController: adminDrawerController),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: animatedContainer(adminDrawerController: adminDrawerController, themeUtils: themeUtils, context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget adminMenuList({required AdminDrawerMenuController adminDrawerController}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adminDrawerController.adminMenuDataList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => AdminDrawerMenuComponent(
            adminMenuDataModel: adminDrawerController.adminMenuDataList[index],
            isSelected: index == adminDrawerController.selectedMenuIndex.value,
            onSelectMenuItem: (selectedMenu) {
              adminDrawerController.setAdminDrawerIndex(adminDrawerController.adminMenuDataList.indexOf(selectedMenu));
              adminDrawerController.selectedMenuIndex.value = adminDrawerController.adminMenuDataList.indexOf(selectedMenu);
              if (adminDrawerController.selectedMenuIndex.value == 0) {
                RouteManagement.goToAdminHomePageView();
              } else if (adminDrawerController.selectedMenuIndex.value == 1) {
                RouteManagement.goToAdminAdsMenuView();
              } else if (adminDrawerController.selectedMenuIndex.value == 3) {
                RouteManagement.goToAdminAllUserView();
              }
            },
          ).marginOnly(bottom: 16),
        );
      },
    );
  }

  Widget adminEndMenuList({required AdminDrawerMenuController adminDrawerController}) {
    int firstMenuListLength = adminDrawerController.adminMenuDataList.length;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: adminDrawerController.adminEndMenuDataList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => AdminDrawerMenuComponent(
            adminMenuDataModel: adminDrawerController.adminEndMenuDataList[index],
            isSelected: (index + firstMenuListLength) == adminDrawerController.selectedMenuIndex.value,
            onSelectMenuItem: (selectedMenu) {
              adminDrawerController.setAdminDrawerIndex(firstMenuListLength + adminDrawerController.adminEndMenuDataList.indexOf(selectedMenu));
              adminDrawerController.selectedMenuIndex.value = firstMenuListLength + adminDrawerController.adminEndMenuDataList.indexOf(selectedMenu);
              if (adminDrawerController.selectedMenuIndex.value == 4) {
                RouteManagement.goToUserMyAccountSettingScreenView();
              } else if (adminDrawerController.selectedMenuIndex.value == 8) {
                RouteManagement.goToAdminLogoutView();
              }
            },
          ).marginOnly(bottom: 16),
        );
      },
    );
  }

  Widget animatedContainer({required AdminDrawerMenuController adminDrawerController, required ThemeColorsUtil themeUtils, required BuildContext context}) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: adminDrawerController.isExpanded.value ? Dimens.oneHundredFortyFive : Dimens.sixtyFive,
        width: Dimens.twoHundredFifty,
        padding: EdgeInsets.all(Dimens.seven),
        decoration: BoxDecoration(
            color: themeUtils.primaryColorSwitch,
            borderRadius: adminDrawerController.isExpanded.value ? BorderRadius.circular(Dimens.thirty) : BorderRadius.circular(Dimens.fifty)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Dimens.fifty,
                  height: Dimens.fifty,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeUtils.blackWhiteSwitchColor, // Background color for the circle
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'admin'.tr.substring(0, 1).toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: Dimens.twenty, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: themeUtils.primaryColorSwitch,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimens.twentyFive),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidgets.autoSizeText(
                          text: 'admin'.tr, textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.blackWhiteSwitchColor), minFontSize: 10, maxFontSize: 14),
                      Padding(
                        padding: EdgeInsets.only(top: Dimens.five),
                        child: CommonWidgets.autoSizeText(
                          text: adminDrawerController.email.value,
                          maxFontSize: 12,
                          minFontSize: 10,
                          textStyle: AppStyles.style12Normal.copyWith(color: themeUtils.blackWhiteSwitchColor.withOpacity(0.70)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedBuilder(
                      animation: adminDrawerController.animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: adminDrawerController.animation.value * -3.1415927,
                          child: child,
                        );
                      },
                      child: InkWell(
                        onTap: () async {
                          adminDrawerController.toggleDashboardProfileMenu();
                        },
                        child: CommonWidgets.fromSvg(
                          svgAsset: SvgAssets.downArrowIcon,
                          color: themeUtils.blackWhiteSwitchColor,
                          width: Dimens.twentyFour,
                          height: Dimens.twentyFour,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.thirteen, bottom: Dimens.ten, left: Dimens.sixTeen, right: Dimens.sixTeen),
                child: Divider(
                  height: 1,
                  color: themeUtils.blackWhiteSwitchColor.withOpacity(0.50),
                ),
              ),
            ),
            if (adminDrawerController.isShowExpandedContent.value)
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.twentySeven),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidgets.fromSvg(
                        svgAsset: ThemeAssetsUtil(context).themeButton,
                        height: Dimens.thirteen,
                        width: Dimens.thirteen,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimens.sevenTeen),
                        child: Text(
                          ThemeStringsUtil(context).lightDarkModeValue,
                          style: AppStyles.style12Normal.copyWith(color: themeUtils.blackWhiteSwitchColor),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              if (adminDrawerController.isExpanded.value) {
                                adminDrawerController.changeTheme();
                              }
                            },
                            child: CommonWidgets.fromSvg(svgAsset: ThemeAssetsUtil(context).themeSwitchSmallButton, width: Dimens.twentySix),
                          ),
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
