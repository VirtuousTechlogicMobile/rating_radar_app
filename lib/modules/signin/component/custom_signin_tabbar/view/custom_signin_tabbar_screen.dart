import 'package:flutter/material.dart';
import '../../../../../../common/common_widgets.dart';
import '../../../../../../constant/assets.dart';
import 'package:get/get.dart';
import '../../../../../../constant/dimens.dart';
import '../../../../../../constant/styles.dart';
import '../../../../../../utility/theme_colors_util.dart';
import '../custom_signin_tabbar_controller.dart';

class CustomSignInTabBar extends StatelessWidget {
  Function(int index) onIndexChange;
  CustomSignInTabBar({super.key, required this.onIndexChange});

  final customSignInTabBarController = Get.find<CustomSignInTabBarController>();
  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeColorsUtil = ThemeColorsUtil(context);
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      customSignInTabBarController.selectedTabIndex.value = 0;
                      onIndexChange(0);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonWidgets.fromSvg(
                            svgAsset: SvgAssets.managerRoundedIcon,
                            margin: EdgeInsets.only(bottom: Dimens.five),
                            width: Dimens.sixty,
                            height: Dimens.sixty,
                            color: themeColorsUtil.primaryColorSwitch),
                        Text(
                          'company'.tr,
                          style: AppStyles.style11SemiBold.copyWith(color: themeColorsUtil.primaryColorSwitch),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      customSignInTabBarController.selectedTabIndex.value = 1;
                      onIndexChange(1);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonWidgets.fromSvg(
                            svgAsset: SvgAssets.userRoundedIcon,
                            margin: EdgeInsets.only(bottom: Dimens.five),
                            width: Dimens.sixty,
                            height: Dimens.sixty,
                            color: themeColorsUtil.primaryColorSwitch),
                        Text(
                          'user'.tr,
                          style: AppStyles.style11SemiBold.copyWith(color: themeColorsUtil.primaryColorSwitch),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(
                () => AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: customSignInTabBarController.selectedTabIndex.value == 1 ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: customSignInTabBarController.selectedTabIndex.value == 0
                        ? EdgeInsets.only(right: Dimens.eight, left: Dimens.seven, top: Dimens.ten, bottom: Dimens.sixTeen)
                        : EdgeInsets.only(top: Dimens.ten, bottom: Dimens.sixTeen, right: Dimens.seven, left: Dimens.seven),
                    width: Dimens.fortyFive,
                    decoration: BoxDecoration(border: Border.all(width: 1, color: themeColorsUtil.primaryColorSwitch), borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
