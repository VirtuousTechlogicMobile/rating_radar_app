import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/modules/admin/admin_header/view/admin_header_view.dart';
import 'package:RatingRadar_app/modules/admin/drawer/view/admin_drawer_view.dart';
import 'package:RatingRadar_app/modules/admin/homepage/admin_homepage_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../user/homepage/components/user_homepage_components.dart';
import '../../../user/homepage/model/user_ads_list_data_model.dart';
import '../../../user/user_all_ads/bindings/user_all_ads_binding.dart';
import '../../admin_header/bindings/admin_header_binding.dart';
import '../components/admin_custom_dropdown.dart';
import '../components/admin_homepage_view_component.dart';
import '../model/admin_homepage_adsviews_data_model.dart';

class AdminHomepageScreen extends StatelessWidget {
  final adminHomePageController = Get.find<AdminHomepageController>();
  AdminHomepageScreen({super.key}) {
    UserAllAdsBinding().dependencies();
    adminHomePageController.getAdsList();
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Scaffold(
      backgroundColor: themeUtils.screensBgSwitchColor,
      body: Row(
        children: [
          AdminDrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                adminHeader(),
                adminScreenMainLayout(
                  themeUtils: themeUtils,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget adminHeader() {
    AdminHeaderBinding().dependencies();
    return AdminHeaderView(
      isDashboardScreen: true,
    );
  }

  Widget adminScreenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.sixtyFive, vertical: Dimens.sixty),
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
                              textStyle: AppStyles.style24SemiBold.copyWith(
                                  color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 20,
                              maxFontSize: 24,
                            ),
                          ),
                          CommonWidgets.autoSizeText(
                            text: 'overall_your_progress'.tr,
                            textStyle: AppStyles.style14Normal
                                .copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 8,
                            maxFontSize: 14,
                          ),
                        ],
                      ),
                      Obx(
                        () => AdminCustomDropdown(
                          dropDownItems:
                              adminHomePageController.adminDropdownItemList,
                          selectedItem:
                              adminHomePageController.adminDropdownItemList[
                                  adminHomePageController
                                      .selectedDropdownItemIndex.value],
                          onItemSelected: (index) async {
                            adminHomePageController
                                .selectedDropdownItemIndex.value = index;
                            await adminHomePageController.getAdsList();
                          },
                        ),
                      ),
                    ],
                  ),

                  /// views
                  Wrap(
                    spacing: ((constraints.maxWidth -
                                    (((constraints.maxWidth /
                                                Dimens.twoHundredTwenty)
                                            .floor()) *
                                        Dimens.twoHundredTwenty)) /
                                (((constraints.maxWidth /
                                            Dimens.twoHundredTwenty)
                                        .floor()) -
                                    1)) >
                            0
                        ? ((constraints.maxWidth -
                                (((constraints.maxWidth /
                                            Dimens.twoHundredTwenty)
                                        .floor()) *
                                    Dimens.twoHundredTwenty)) /
                            (((constraints.maxWidth / Dimens.twoHundredTwenty)
                                    .floor()) -
                                1))
                        : Dimens.thirty,
                    children: List.generate(
                      4,
                      (index) {
                        return AdminHomepageViewComponent(
                          themeUtils: themeUtils,
                          index: index,
                          listLength: 4,
                          viewsModel: AdminHomepageAdsViewsDataModel(
                              totalViews: 1265,
                              isMarketValueUp: true,
                              marketValuePercentage: 11.02),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimens.twentySix, bottom: Dimens.nine),
                    child: CommonWidgets.autoSizeText(
                      text: 'recent_ads'.tr,
                      textStyle: AppStyles.style24Normal.copyWith(
                          color: themeUtils.whiteBlackSwitchColor,
                          fontWeight: FontWeight.w600),
                      minFontSize: 15,
                      maxFontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidgets.autoSizeText(
                        text: 'best_recent_ads'.tr,
                        textStyle: AppStyles.style14Normal
                            .copyWith(color: themeUtils.primaryColorSwitch),
                        minFontSize: 8,
                        maxFontSize: 14,
                      ),
                      InkWell(
                        onTap: () {
                          RouteManagement.goToUserAllAdsListScreenView();
                        },
                        child: CommonWidgets.autoSizeText(
                          text: 'view_all'.tr,
                          textStyle: AppStyles.style14Normal
                              .copyWith(color: themeUtils.primaryColorSwitch),
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
                          spacing: ((constraints.maxWidth -
                                          (((constraints.maxWidth /
                                                      Dimens.threeHundredTwenty)
                                                  .floor()) *
                                              Dimens.threeHundredTwenty)) /
                                      (((constraints.maxWidth /
                                                  Dimens.threeHundredTwenty)
                                              .floor()) -
                                          1)) >
                                  0
                              ? ((constraints.maxWidth -
                                      (((constraints.maxWidth /
                                                  Dimens.threeHundredTwenty)
                                              .floor()) *
                                          Dimens.threeHundredTwenty)) /
                                  (((constraints.maxWidth /
                                              Dimens.threeHundredTwenty)
                                          .floor()) -
                                      1))
                              : Dimens.sixTeen,
                          children: List.generate(
                            adminHomePageController.adsList.value?.length ?? 0,
                            (index) {
                              return UserAdViewComponent(
                                themeColorUtil: themeUtils,
                                userAdsListDataModel: UserAdsListDataModel(
                                  adName: adminHomePageController
                                          .adsList.value?[index].adName ??
                                      '',
                                  adContent: adminHomePageController
                                          .adsList.value?[index].adContent ??
                                      '',
                                  byCompany: adminHomePageController
                                          .adsList.value?[index].byCompany ??
                                      '',
                                  imageUrl: adminHomePageController
                                          .adsList.value?[index].imageUrl ??
                                      '',
                                  adPrice: adminHomePageController
                                          .adsList.value?[index].adPrice ??
                                      0,
                                ),
                                onViewButtonTap: () {
                                  RouteManagement.goToUserSubmitAdScreenView(
                                      adDocumentId: adminHomePageController
                                              .adsList.value?[index].docId ??
                                          '');
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
