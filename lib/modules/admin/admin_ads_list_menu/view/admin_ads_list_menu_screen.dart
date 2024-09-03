import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/modules/admin/admin_header/bindings/admin_header_binding.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';
import '../admin_ads_list_menu_controller.dart';
import '../components/ads_list_custom_dropdown.dart';
import '../components/custom_pagination_widget.dart';

class AdminAdsListMenuScreen extends StatelessWidget {
  final adminAdsListMenuController = Get.find<AdminAdsListMenuController>();

  AdminAdsListMenuScreen({super.key}) {
    adminAdsListMenuController.getAdsData();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ThemeColorsUtil themeUtils;

  @override
  Widget build(BuildContext context) {
    themeUtils = ThemeColorsUtil(context);
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
                adminScreenMainLayout(themeUtils: themeUtils),
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
      isDashboardScreen: false,
      isAdsListScreen: true,
    );
  }

  Widget adminScreenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          margin: EdgeInsets.only(
              top: Dimens.thirtyFour,
              left: Dimens.twentyFour,
              right: Dimens.twentyFour,
              bottom: Dimens.forty),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.thirty),
            color: themeUtils.deepBlackWhiteSwitchColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 60,
                spreadRadius: 0,
                color:
                    themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimens.thirtyEight,
                    right: Dimens.thirtyEight,
                    bottom: Dimens.forty,
                    top: Dimens.twentyEight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.seven),
                          child: CommonWidgets.autoSizeText(
                            text: 'all_ads'.tr,
                            textStyle: AppStyles.style24Bold.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'active_ads'.tr,
                            textStyle: AppStyles.style14Normal
                                .copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Dimens.fifteen),
                          child: InkWell(
                            onTap: () {
                              /// ******************* Todo : add ads ********************
                              RouteManagement.goToAdminSubmitAdScreenView();
                            },
                            child: Container(
                              height: Dimens.thirtyEight,
                              width: Dimens.oneHundredFiftyFive,
                              decoration: BoxDecoration(
                                  color: themeUtils.primaryColorSwitch,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.twenty)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.plus_icon,
                                    width: Dimens.fourteen,
                                    height: Dimens.fourteen,
                                    color: themeUtils.blackWhiteSwitchColor,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: Dimens.fifteen),
                                    child: Text(
                                      'add_ads'.tr,
                                      style: AppStyles.style14SemiBold.copyWith(
                                        color: themeUtils.blackWhiteSwitchColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// custom dropdown
                        Obx(
                          () => AdsListCustomDropdown(
                            dropDownItems:
                                adminAdsListMenuController.adsListDropDownList,
                            selectedItem:
                                adminAdsListMenuController.adsListDropDownList[
                                    adminAdsListMenuController
                                        .selectedDropDownIndex.value],
                            onItemSelected: (index) {
                              adminAdsListMenuController
                                  .selectedDropDownIndex.value = index;
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              /// ads list layout
              Obx(
                () => Visibility(
                  visible: adminAdsListMenuController
                      .adminSubmittedAdsList.isNotEmpty,
                  child: Expanded(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Dimens.fifty,
                            width: constraints.maxWidth,
                            padding: EdgeInsets.only(
                                left: Dimens.forty,
                                top: Dimens.fifteen,
                                bottom: Dimens.fifteen),
                            margin: EdgeInsets.only(
                                left: Dimens.thirtyEight,
                                right: Dimens.thirtyEight,
                                bottom: Dimens.fifteen),
                            decoration: BoxDecoration(
                              color: themeUtils.darkGrayOfWhiteSwitchColor,
                              borderRadius:
                                  BorderRadius.circular(Dimens.twentyFive),
                            ),
                            child: tableHeader(),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  adminAdsListMenuController
                                      .adminSubmittedAdsList.length,
                                  (index) {
                                    return Column(
                                      children: [
                                        if (index == 0)
                                          Divider(
                                            thickness: 1,
                                            color:
                                                themeUtils.dividerSwitchColor,
                                          ),
                                        customTableRow(
                                          task: adminAdsListMenuController
                                              .adminSubmittedAdsList[index]
                                              .userName,
                                          company: adminAdsListMenuController
                                              .adminSubmittedAdsList[index]
                                              .company,
                                          email: adminAdsListMenuController
                                              .adminSubmittedAdsList[index]
                                              .email,
                                          date: adminAdsListMenuController
                                              .parseDate(
                                                  adminAdsListMenuController
                                                      .adminSubmittedAdsList[
                                                          index]
                                                      .date),
                                          price: adminAdsListMenuController
                                              .adminSubmittedAdsList[index]
                                              .taskPrice
                                              .toString(),
                                          status: adminAdsListMenuController
                                              .adminSubmittedAdsList[index]
                                              .adStatus,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: themeUtils.dividerSwitchColor,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: Dimens.forty,
                                left: Dimens.forty,
                                right: Dimens.forty,
                                bottom: Dimens.forty),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonWidgets.autoSizeText(
                                  text: 'Showing data 1 to 9 of  256K entries',
                                  textStyle: AppStyles.style14SemiBold.copyWith(
                                    color: themeUtils
                                        .fontColorBlackWhiteSwitchColor,
                                  ),
                                  maxLines: 2,
                                  minFontSize: 8,
                                  maxFontSize: 14,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimens.twenty),
                                  child: CustomPaginationWidget(
                                    currentPage: 12,
                                    totalCount: 100,
                                    onPageChanged: (currentPage) {},
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget tableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Task'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Company'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Email'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Location'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Date'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Task price'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Status'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        )
      ],
    );
  }

  Widget customTableRow({
    required String task,
    required String company,
    required String email,
    required String date,
    required String price,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.eighty,
          right: Dimens.forty,
          top: Dimens.twenty,
          bottom: Dimens.twenty),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: CommonWidgets.autoSizeText(
              text: task,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              maxLines: 2,
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 1,
            child: CommonWidgets.autoSizeText(
              text: company,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonWidgets.autoSizeText(
              text: email,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              maxLines: 2,
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 1,
            child: CommonWidgets.autoSizeText(
              text: 'United States',
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              maxLines: 2,
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 1,
            child: CommonWidgets.autoSizeText(
              text: date,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 1,
            child: CommonWidgets.autoSizeText(
              text: price,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dimens.six, horizontal: Dimens.fourteen),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: status == CustomStatus.rejected
                    ? ColorValues.statusColorRed.withOpacity(0.38)
                    : status == CustomStatus.pending
                        ? ColorValues.statusColorYellow.withOpacity(0.38)
                        : status == CustomStatus.blocked
                            ? ColorValues.statusColorBlack.withOpacity(0.38)
                            : ColorValues.statusColorGreen.withOpacity(0.38),
                border: Border.all(
                  color: status == CustomStatus.rejected
                      ? ColorValues.statusColorRed
                      : status == CustomStatus.pending
                          ? ColorValues.statusColorYellow
                          : status == CustomStatus.blocked
                              ? ColorValues.statusColorBlack
                              : ColorValues.statusColorGreen,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Dimens.twenty),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimens.seven,
                    width: Dimens.seven,
                    margin: EdgeInsets.only(right: Dimens.five),
                    decoration: BoxDecoration(
                      color: status == CustomStatus.rejected
                          ? ColorValues.statusColorRed
                          : status == CustomStatus.pending
                              ? ColorValues.statusColorYellow
                              : status == CustomStatus.blocked
                                  ? ColorValues.statusColorBlack
                                  : ColorValues.statusColorGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Flexible(
                    child: CommonWidgets.autoSizeText(
                      text: status,
                      textStyle: AppStyles.style14SemiBold.copyWith(
                        color: status == CustomStatus.rejected
                            ? ColorValues.statusColorRed
                            : status == CustomStatus.pending
                                ? ColorValues.statusColorYellow
                                : status == CustomStatus.blocked
                                    ? ColorValues.statusColorBlack
                                    : ColorValues.statusColorGreen,
                      ),
                      minFontSize: 8,
                      maxFontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
