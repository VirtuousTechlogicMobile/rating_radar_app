import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/modules/user/header/header_controller.dart';
import 'package:flutter/material.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import 'package:get/get.dart';
import '../../../../utility/theme_colors_util.dart';

class HeaderView extends StatelessWidget {
  final bool isAdsListScreen;
  final bool isDashboardScreen;
  final TextEditingController? searchController;
  final Function(String text)? onSearch;
  final headerController = Get.find<HeaderController>();
  HeaderView({super.key, this.isAdsListScreen = false, this.isDashboardScreen = false, this.searchController, this.onSearch}) {
    headerController.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Padding(
      padding: EdgeInsets.only(top: Dimens.thirty, left: Dimens.eightyThree, right: Dimens.thirtyFour),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAdsListScreen)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CommonWidgets.autoSizeText(
                        text: '${'hello'.tr} ${headerController.userName.value.split(' ')[0]}',
                        textStyle: AppStyles.style24SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                        minFontSize: 20,
                        maxFontSize: 24,
                      ),
                    ),
                    Hero(
                      tag: 'headerSearchField',
                      child: Material(
                        color: ColorValues.transparent,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimens.twentySeven),
                          width: MediaQuery.of(context).size.width / 3,
                          child: CustomTextField(
                            controller: searchController ?? TextEditingController(),
                            onChange: (value) {
                              if (onSearch != null) {
                                onSearch!(value);
                              }
                            },
                            borderRadius: BorderRadius.circular(Dimens.twenty),
                            fillColor: themeUtils.darkGrayWhiteSwitchColor,
                            maxLines: 1,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'search'.tr,
                            borderSide: BorderSide.none,
                            hintStyle: AppStyles.style14Normal.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                            textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                            prefixIcon: CommonWidgets.fromSvg(
                              svgAsset: SvgAssets.textFieldSearchIcon,
                              height: Dimens.twentyFour,
                              width: Dimens.twentyFour,
                              color: themeUtils.primaryColorSwitch,
                              margin: EdgeInsets.only(left: Dimens.eleven, top: Dimens.seven, bottom: Dimens.seven, right: Dimens.eight),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: themeUtils.deepBlackWhiteSwitchColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorValues.blackColor.withOpacity(0.15),
                              offset: const Offset(0, 5),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CommonWidgets.fromSvg(
                            svgAsset: SvgAssets.settingsIcon,
                            margin: EdgeInsets.symmetric(horizontal: Dimens.fifteen, vertical: Dimens.twelve),
                            color: themeUtils.primaryColorSwitch),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimens.fifteen),
                        decoration: BoxDecoration(
                          color: themeUtils.deepBlackWhiteSwitchColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorValues.blackColor.withOpacity(0.15),
                              offset: const Offset(0, 5),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CommonWidgets.fromSvg(
                            svgAsset: SvgAssets.notificationsBellIcon,
                            margin: EdgeInsets.symmetric(horizontal: Dimens.fifteen, vertical: Dimens.twelve),
                            color: themeUtils.primaryColorSwitch),
                      ),
                    ],
                  ),
                )
              ],
            ),
          if (isDashboardScreen)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox.shrink(),
                Hero(
                  tag: 'headerSearchField',
                  child: Material(
                    color: ColorValues.transparent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: CustomTextField(
                        controller: TextEditingController(),
                        borderRadius: BorderRadius.circular(Dimens.twenty),
                        fillColor: themeUtils.darkGrayWhiteSwitchColor,
                        maxLines: 1,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'search'.tr,
                        borderSide: BorderSide.none,
                        hintStyle: AppStyles.style14Normal.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                        textStyle: AppStyles.style14Normal.copyWith(color: ColorValues.whiteColor.withOpacity(0.50)),
                        prefixIcon: CommonWidgets.fromSvg(
                          svgAsset: SvgAssets.textFieldSearchIcon,
                          height: Dimens.twentyFour,
                          width: Dimens.twentyFour,
                          color: themeUtils.primaryColorSwitch,
                          margin: EdgeInsets.only(left: Dimens.eleven, top: Dimens.seven, bottom: Dimens.seven, right: Dimens.eight),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// settings icon
                    Container(
                      decoration: BoxDecoration(
                        color: themeUtils.deepBlackWhiteSwitchColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorValues.blackColor.withOpacity(0.15),
                            offset: const Offset(0, 5),
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: headerController.isSettingsIconHovered.value ? Dimens.fifty : 0.0,
                              height: headerController.isSettingsIconHovered.value ? Dimens.fifty : 0.0,
                              decoration: BoxDecoration(
                                color: themeUtils.primaryColorSwitch,
                                shape: BoxShape.circle,
                              ),
                            ),
                            MouseRegion(
                              cursor: MouseCursor.uncontrolled,
                              onEnter: (event) {
                                headerController.isSettingsIconHovered.value = true;
                              },
                              onExit: (event) {
                                headerController.isSettingsIconHovered.value = false;
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: Dimens.fifty,
                                height: Dimens.fifty,
                                child: CommonWidgets.fromSvg(
                                  svgAsset: SvgAssets.settingsIcon,
                                  color: headerController.isSettingsIconHovered.value ? themeUtils.blackWhiteSwitchColor : themeUtils.primaryColorSwitch,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// notification icon
                    Container(
                      width: Dimens.fifty,
                      height: Dimens.fifty,
                      margin: EdgeInsets.only(left: Dimens.fifteen),
                      decoration: BoxDecoration(
                        color: themeUtils.deepBlackWhiteSwitchColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorValues.blackColor.withOpacity(0.15),
                            offset: const Offset(0, 5),
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Obx(
                        () => Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: headerController.isBellIconHovered.value ? Dimens.fifty : 0.0,
                              height: headerController.isBellIconHovered.value ? Dimens.fifty : 0.0,
                              decoration: BoxDecoration(
                                color: themeUtils.primaryColorSwitch,
                                shape: BoxShape.circle,
                              ),
                            ),
                            MouseRegion(
                              cursor: MouseCursor.uncontrolled,
                              onEnter: (event) {
                                headerController.isBellIconHovered.value = true;
                              },
                              onExit: (event) {
                                headerController.isBellIconHovered.value = false;
                              },
                              child: Container(
                                width: Dimens.fifty,
                                height: Dimens.fifty,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CommonWidgets.fromSvg(
                                  svgAsset: SvgAssets.notificationsBellIcon,
                                  color: headerController.isBellIconHovered.value ? themeUtils.blackWhiteSwitchColor : themeUtils.primaryColorSwitch,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          if (!isAdsListScreen && !isDashboardScreen)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// settings icon
                Container(
                  decoration: BoxDecoration(
                    color: themeUtils.deepBlackWhiteSwitchColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorValues.blackColor.withOpacity(0.15),
                        offset: const Offset(0, 5),
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: headerController.isSettingsIconHovered.value ? Dimens.fifty : 0.0,
                          height: headerController.isSettingsIconHovered.value ? Dimens.fifty : 0.0,
                          decoration: BoxDecoration(
                            color: themeUtils.primaryColorSwitch,
                            shape: BoxShape.circle,
                          ),
                        ),
                        MouseRegion(
                          cursor: MouseCursor.uncontrolled,
                          onEnter: (event) {
                            headerController.isSettingsIconHovered.value = true;
                          },
                          onExit: (event) {
                            headerController.isSettingsIconHovered.value = false;
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            width: Dimens.fifty,
                            height: Dimens.fifty,
                            child: CommonWidgets.fromSvg(
                              svgAsset: SvgAssets.settingsIcon,
                              color: headerController.isSettingsIconHovered.value ? themeUtils.blackWhiteSwitchColor : themeUtils.primaryColorSwitch,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// notification icon
                Container(
                  width: Dimens.fifty,
                  height: Dimens.fifty,
                  margin: EdgeInsets.only(left: Dimens.fifteen),
                  decoration: BoxDecoration(
                    color: themeUtils.deepBlackWhiteSwitchColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorValues.blackColor.withOpacity(0.15),
                        offset: const Offset(0, 5),
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: headerController.isBellIconHovered.value ? Dimens.fifty : 0.0,
                          height: headerController.isBellIconHovered.value ? Dimens.fifty : 0.0,
                          decoration: BoxDecoration(
                            color: themeUtils.primaryColorSwitch,
                            shape: BoxShape.circle,
                          ),
                        ),
                        MouseRegion(
                          cursor: MouseCursor.uncontrolled,
                          onEnter: (event) {
                            headerController.isBellIconHovered.value = true;
                          },
                          onExit: (event) {
                            headerController.isBellIconHovered.value = false;
                          },
                          child: Container(
                            width: Dimens.fifty,
                            height: Dimens.fifty,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CommonWidgets.fromSvg(
                              svgAsset: SvgAssets.notificationsBellIcon,
                              color: headerController.isBellIconHovered.value ? themeUtils.blackWhiteSwitchColor : themeUtils.primaryColorSwitch,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
