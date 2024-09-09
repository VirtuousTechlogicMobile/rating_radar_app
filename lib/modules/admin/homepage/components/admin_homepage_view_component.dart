import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../../../utility/utility.dart';
import '../admin_homepage_controller.dart';
import '../model/admin_homepage_ads_view_model.dart';

class AdminHomepageViewComponent extends StatelessWidget {
  final ThemeColorsUtil themeUtils;
  final AdminHomepageAdsViewsDataModel viewsModel;
  final int index;
  final int listLength;
  final adminHomePageController = Get.find<AdminHomepageController>();

  AdminHomepageViewComponent(
      {super.key,
      required this.themeUtils,
      required this.index,
      required this.listLength,
      required this.viewsModel}) {
    adminHomePageController.isViewComponentHoveredList.value =
        List.generate(listLength, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: Dimens.twentyFive),
      decoration: BoxDecoration(
        color: themeUtils.primaryLightColorSwitch,
        borderRadius: BorderRadius.circular(Dimens.twelve),
        boxShadow: [
          BoxShadow(
            color: ColorValues.blackColor.withOpacity(0.10),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: adminHomePageController.isViewComponentHoveredList[index]
                  ? Dimens.twoHundredTwenty
                  : 0.0,
              height: adminHomePageController.isViewComponentHoveredList[index]
                  ? Dimens.oneHundredTwenty
                  : 0.0,
              decoration: BoxDecoration(
                color: themeUtils.primaryColorSwitch,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            MouseRegion(
              onEnter: (event) {
                adminHomePageController.isViewComponentHoveredList[index] =
                    true;
              },
              onExit: (event) {
                adminHomePageController.isViewComponentHoveredList[index] =
                    false;
              },
              child: Container(
                height: Dimens.oneHundredTwenty,
                width: Dimens.twoHundredTwenty,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimens.twentySix),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonWidgets.autoSizeText(
                      text: 'views'.tr,
                      textStyle: AppStyles.style13semiBold
                          .copyWith(color: ColorValues.darkCharcoalColor),
                      minFontSize: 7,
                      maxFontSize: 13,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimens.eight),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonWidgets.autoSizeText(
                            text:
                                AppUtility.formatNumber(viewsModel.totalViews),
                            textStyle: AppStyles.style26Normal.copyWith(
                                color: ColorValues.darkCharcoalColor,
                                fontWeight: FontWeight.w600),
                            minFontSize: 10,
                            maxFontSize: 26,
                          ),
                          const Spacer(),
                          CommonWidgets.autoSizeText(
                            text: AppUtility.formatNumberAsMarketValue(
                                value: 11.02,
                                isMarketValueUp: viewsModel.isMarketValueUp),
                            textStyle: AppStyles.style13Normal
                                .copyWith(color: ColorValues.darkCharcoalColor),
                            minFontSize: 10,
                            maxFontSize: 26,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Dimens.four),
                            child: viewsModel.isMarketValueUp
                                ? CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.marketValueUpIcon,
                                    height: Dimens.sevenTeen,
                                    width: Dimens.sevenTeen)
                                : Transform.rotate(
                                    angle: 35 * pi,
                                    child: CommonWidgets.fromSvg(
                                        svgAsset: SvgAssets.marketValueUpIcon,
                                        height: Dimens.sevenTeen,
                                        width: Dimens.sevenTeen),
                                  ),
                          ),
                        ],
                      ),
                    )
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
