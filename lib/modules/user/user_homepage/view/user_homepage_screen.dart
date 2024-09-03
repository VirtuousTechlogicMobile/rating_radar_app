import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/modules/user/header/bindings/header_binding.dart';
import 'package:RatingRadar_app/modules/user/user_all_ads/bindings/user_all_ads_binding.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/dimens.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../components/custom_dropdown.dart';
import '../components/user_homepage_components.dart';
import '../components/user_homepage_view_component.dart';
import '../model/user_ads_list_data_model.dart';
import '../model/user_homepage_adsviews_data_model.dart';
import '../user_homepage_controller.dart';

class UserHomepageScreen extends StatelessWidget {
  final userHomePageController = Get.find<UserHomepageController>();

  UserHomepageScreen({super.key}) {
    UserAllAdsBinding().dependencies();
    userHomePageController.getAdsList();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
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
                screenMainLayout(
                  themeUtils: themeUtils,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    HeaderBinding().dependencies();
    return HeaderView(
      isDashboardScreen: true,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.sixtyFive, vertical: Dimens.sixty),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: Dimens.eight),
                            child: CommonWidgets.autoSizeText(
                              text: 'overview'.tr,
                              textStyle: AppStyles.style24SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 20,
                              maxFontSize: 24,
                            ),
                          ),
                          CommonWidgets.autoSizeText(
                            text: 'overall_your_progress'.tr,
                            textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 8,
                            maxFontSize: 14,
                          ),
                        ],
                      ),
                      Obx(
                        () => CustomDropdown(
                          dropDownItems: userHomePageController.dropdownItemsList,
                          selectedItem: userHomePageController.dropdownItemsList[userHomePageController.selectedDropDownItemIndex.value],
                          onItemSelected: (index) async {
                            userHomePageController.selectedDropDownItemIndex.value = index;
                            await userHomePageController.getAdsList();
                          },
                        ),
                      ),
                    ],
                  ),

                  /// views
                  Wrap(
                    spacing: ((constraints.maxWidth - (((constraints.maxWidth / Dimens.twoHundredTwenty).floor()) * Dimens.twoHundredTwenty)) /
                                (((constraints.maxWidth / Dimens.twoHundredTwenty).floor()) - 1)) >
                            0
                        ? ((constraints.maxWidth - (((constraints.maxWidth / Dimens.twoHundredTwenty).floor()) * Dimens.twoHundredTwenty)) /
                            (((constraints.maxWidth / Dimens.twoHundredTwenty).floor()) - 1))
                        : Dimens.thirty,
                    children: List.generate(
                      4,
                      (index) {
                        return UserHomepageViewComponent(
                          themeUtils: themeUtils,
                          index: index,
                          listLength: 4,
                          viewsModel: UserHomepageAdsViewsDataModel(totalViews: 1265, isMarketValueUp: true, marketValuePercentage: 11.02),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: Dimens.twentySix, bottom: Dimens.nine),
                    child: CommonWidgets.autoSizeText(
                      text: 'recent_ads'.tr,
                      textStyle: AppStyles.style24Normal.copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w600),
                      minFontSize: 15,
                      maxFontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidgets.autoSizeText(
                        text: 'best_recent_ads'.tr,
                        textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                        minFontSize: 8,
                        maxFontSize: 14,
                      ),
                      InkWell(
                        onTap: () {
                          RouteManagement.goToUserAllAdsListScreenView();
                        },
                        child: CommonWidgets.autoSizeText(
                          text: 'view_all'.tr,
                          textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                          minFontSize: 8,
                          maxFontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Hero(
                    tag: 'userAllAdsList',
                    child: Material(
                      color: Colors.transparent,
                      child: Obx(
                        () => Wrap(
                          /// calculate the spacing between items
                          spacing: ((constraints.maxWidth - (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) * Dimens.threeHundredTwenty)) /
                                      (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) - 1)) >
                                  0
                              ? ((constraints.maxWidth - (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) * Dimens.threeHundredTwenty)) /
                                  (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) - 1))
                              : Dimens.sixTeen,
                          children: List.generate(
                            userHomePageController.adsList.value?.length ?? 0,
                            (index) {
                              return UserAdViewComponent(
                                themeColorUtil: themeUtils,
                                userAdsListDataModel: UserAdsListDataModel(
                                  adName: userHomePageController.adsList.value?[index].adName ?? '',
                                  adContent: userHomePageController.adsList.value?[index].adContent ?? '',
                                  byCompany: userHomePageController.adsList.value?[index].byCompany ?? '',
                                  imageUrl: userHomePageController.adsList.value?[index].imageUrl ?? '',
                                  adPrice: userHomePageController.adsList.value?[index].adPrice ?? 0,
                                ),
                                onViewButtonTap: () {
                                  RouteManagement.goToUserSubmitAdScreenView(adDocumentId: userHomePageController.adsList.value?[index].docId ?? '');
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
