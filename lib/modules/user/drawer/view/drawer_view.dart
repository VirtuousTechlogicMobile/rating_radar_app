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
import '../bindings/drawer_binding.dart';
import '../component/drawer_menu_component.dart';
import '../drawer_controller.dart';

class DrawerView extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  DrawerView({super.key, required this.scaffoldKey}) {
    DrawerBinding().dependencies();
  }

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> with SingleTickerProviderStateMixin {
  final drawerController = Get.find<DrawerMenuController>();

  @override
  void initState() {
    super.initState();
    drawerController.getUserName();
    drawerController.animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Duration of the animation
      vsync: this,
    );

    drawerController.animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: drawerController.animationController,
        curve: Curves.linear, // Linear rotation
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Hero(
      tag: 'drawer',
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
                child: menuList(drawerController: drawerController),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: endMenuList(drawerController: drawerController),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: animatedContainer(drawerController: drawerController, themeUtils: themeUtils, context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menuList({required DrawerMenuController drawerController}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: drawerController.menuDataList.length,
    itemBuilder: (context, index) {
      return Obx(
        () => DrawerMenuComponent(
          menuDataModel: drawerController.menuDataList[index],
          isSelected: index == drawerController.selectedMenuIndex.value,
          onSelectMenuItem: (selectedMenu) {
            drawerController.selectedMenuIndex.value = drawerController.menuDataList.indexOf(selectedMenu);
            if (drawerController.selectedMenuIndex.value == 0) {
              RouteManagement.goToUserHomePageView();
            } else if (drawerController.selectedMenuIndex.value == 1) {
              RouteManagement.goToUserAdsListMenuView();
            } else {
              // RouteManagement.goToUserSignInView();
            }
          },
        ).marginOnly(bottom: 16),
      );
    },
  );
}

Widget endMenuList({required DrawerMenuController drawerController}) {
  int firstMenuListLength = drawerController.menuDataList.length;
  return ListView.builder(
    shrinkWrap: true,
    itemCount: drawerController.endMenuDataList.length,
    itemBuilder: (context, index) {
      return Obx(
        () => DrawerMenuComponent(
          menuDataModel: drawerController.endMenuDataList[index],
          isSelected: (index + firstMenuListLength) == drawerController.selectedMenuIndex.value,
          onSelectMenuItem: (selectedMenu) {
            drawerController.selectedMenuIndex.value = firstMenuListLength + drawerController.endMenuDataList.indexOf(selectedMenu);
            if (drawerController.selectedMenuIndex.value == 6) {
              RouteManagement.goToLogoutView();
            }
          },
        ).marginOnly(bottom: 16),
      );
    },
  );
}

Widget animatedContainer({required DrawerMenuController drawerController, required ThemeColorsUtil themeUtils, required BuildContext context}) {
  return Obx(
    () => AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: drawerController.isExpanded.value ? Dimens.oneHundredFortyFive : Dimens.sixtyFive,
      width: Dimens.twoHundredFifty,
      padding: EdgeInsets.all(Dimens.seven),
      decoration: BoxDecoration(
          color: themeUtils.primaryColorSwitch, borderRadius: drawerController.isExpanded.value ? BorderRadius.circular(Dimens.thirty) : BorderRadius.circular(Dimens.fifty)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
                  width: Dimens.fifty,
                  height: Dimens.fifty,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimens.twentyEight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drawerController.userName.value.split(' ')[0],
                      style: AppStyles.style14SemiBold.copyWith(color: themeUtils.blackWhiteSwitchColor),
                    ),
                    Text(
                      'user'.tr,
                      style: AppStyles.style12Normal.copyWith(
                        color: themeUtils.blackWhiteSwitchColor.withOpacity(0.70),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: AnimatedBuilder(
                      animation: drawerController.animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: drawerController.animation.value * -3.1415927,
                          child: child,
                        );
                      },
                      child: InkWell(
                        onTap: () async {
                          drawerController.toggleDashboardProfileMenu();
                        },
                        child:
                            CommonWidgets.fromSvg(svgAsset: SvgAssets.downArrowIcon, color: themeUtils.blackWhiteSwitchColor, width: Dimens.twentyFour, height: Dimens.twentyFour),
                      ),
                    ),
                  ),
                ),
              )
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
          if (drawerController.isShowExpandedContent.value)
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.twentySeven),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonWidgets.fromSvg(svgAsset: ThemeAssetsUtil(context).themeButton, height: Dimens.thirteen, width: Dimens.thirteen),
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
                            if (drawerController.isExpanded.value) {
                              drawerController.changeTheme();
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
