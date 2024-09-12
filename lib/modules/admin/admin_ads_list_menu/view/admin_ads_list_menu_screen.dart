import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../user/user_ads_list_menu/components/custom_pagination_widget.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';
import '../admin_ads_list_menu_controller.dart';
import '../components/admin_ads_list_custom_dropdown.dart';

class AdminAdsListMenuScreen extends StatelessWidget {
  final adminAdsListMenuController = Get.find<AdminAdsListMenuController>();

  AdminAdsListMenuScreen({super.key}) {
    adminAdsListMenuController.getAdsCount();
    adminAdsListMenuController.getAdsData(sortBy: adminAdsListMenuController.selectedDropDownIndex.value);
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

  Widget adminDrawerView() {
    return AdminDrawerView(scaffoldKey: scaffoldKey);
  }

  Widget adminHeader() {
    return AdminHeaderView(
      isDashboardScreen: false,
      isAdsListScreen: true,
      onSearch: (text) async {
        await Future.delayed(const Duration(milliseconds: 500));
        adminAdsListMenuController.getAdsData(sortBy: adminAdsListMenuController.selectedDropDownIndex.value, searchTerm: text);
      },
    );
  }

  Widget adminScreenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          margin: EdgeInsets.only(top: Dimens.thirtyFour, left: Dimens.twentyFour, right: Dimens.twentyFour, bottom: Dimens.forty),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.thirty),
            color: themeUtils.deepBlackWhiteSwitchColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 60,
                spreadRadius: 0,
                color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, top: Dimens.twentyEight),
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
                            textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'active_ads'.tr,
                            textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            RouteManagement.goToAdminCreatedAdScreenView();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: Dimens.fifteen),
                            child: Container(
                              height: Dimens.thirtyEight,
                              width: Dimens.oneHundredFiftyFive,
                              decoration: BoxDecoration(color: themeUtils.primaryColorSwitch, borderRadius: BorderRadius.circular(Dimens.twenty)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.plusIcon,
                                    width: Dimens.fourteen,
                                    height: Dimens.fourteen,
                                    color: themeUtils.blackWhiteSwitchColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: Dimens.fifteen),
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
                          () => AdminAdsListCustomDropdown(
                            dropDownItems: adminAdsListMenuController.adsListDropDownList,
                            selectedItem: adminAdsListMenuController.adsListDropDownList[adminAdsListMenuController.selectedDropDownIndex.value],
                            onItemSelected: (index) {
                              adminAdsListMenuController.selectedDropDownIndex.value = index;
                              adminAdsListMenuController.getAdsData(sortBy: adminAdsListMenuController.selectedDropDownIndex.value);
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
                  visible: adminAdsListMenuController.adminCreatedAdsList.isNotEmpty,
                  replacement: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Dimens.sixtyFive),
                      child: Center(
                        child: CommonWidgets.autoSizeText(
                          text: 'no_data_available_right_now'.tr,
                          textStyle: AppStyles.style35SemiBold.copyWith(color: ColorValues.noDataTextColor),
                          minFontSize: 20,
                          maxFontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  child: Expanded(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimens.forty),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Dimens.fifty,
                              width: constraints.maxWidth,
                              padding: EdgeInsets.only(left: Dimens.forty, top: Dimens.fifteen, bottom: Dimens.fifteen),
                              margin: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.fifteen),
                              decoration: BoxDecoration(
                                color: themeUtils.darkGrayOfWhiteSwitchColor,
                                borderRadius: BorderRadius.circular(Dimens.twentyFive),
                              ),
                              child: tableHeader(),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                    adminAdsListMenuController.adminCreatedAdsList.length,
                                    (index) {
                                      return MouseRegion(
                                        onEnter: (_) => adminAdsListMenuController.isHoveredList[index].value = true,
                                        onExit: (_) => adminAdsListMenuController.isHoveredList[index].value = false,
                                        child: Obx(() => InkWell(
                                              onTap: () {
                                                RouteManagement.goToAdminViewScreenView(
                                                  adDocumentId: adminAdsListMenuController.adminCreatedAdsList[index].docId ?? "",
                                                  whenComplete: () {
                                                    adminAdsListMenuController.getAdsData(sortBy: adminAdsListMenuController.selectedDropDownIndex.value);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: adminAdsListMenuController.isHoveredList[index].value
                                                      ? themeUtils.darkGrayOfWhiteSwitchColor.withOpacity(0.5)
                                                      : Colors.transparent, // Background color based on hover
                                                  border: adminAdsListMenuController.isHoveredList[index].value
                                                      ? Border.all(
                                                          color: themeUtils.borderTableHoverColor,
                                                          width: 1,
                                                        )
                                                      : Border(
                                                          top: BorderSide(color: themeUtils.dividerSwitchColor),
                                                          bottom: BorderSide(color: themeUtils.dividerSwitchColor),
                                                          left: BorderSide.none,
                                                          right: BorderSide.none,
                                                        ),
                                                ),
                                                child: customTableRow(
                                                  task: adminAdsListMenuController.adminCreatedAdsList[index].adName,
                                                  company: adminAdsListMenuController.adminCreatedAdsList[index].byCompany,
                                                  email: "admin@gmail.com",
                                                  date: adminAdsListMenuController.parseDate(adminAdsListMenuController.adminCreatedAdsList[index].addedDate),
                                                  price: adminAdsListMenuController.adminCreatedAdsList[index].adPrice.toString(),
                                                  location: adminAdsListMenuController.adminCreatedAdsList[index].adLocation!.isEmpty
                                                      ? 'United States'
                                                      : adminAdsListMenuController.adminCreatedAdsList[index].adLocation ?? "",
                                                  status: adminAdsListMenuController.adminCreatedAdsList[index].companyAdAction ?? "status",
                                                ),
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Dimens.forty, left: Dimens.forty, right: Dimens.forty, bottom: Dimens.forty),
                              child: Obx(
                                () => CustomPaginationWidget(
                                  currentPage: adminAdsListMenuController.selectedPage.value,
                                  totalCount: adminAdsListMenuController.totalAdminSubmittedAds.value,
                                  onPageChanged: (currentPage) {
                                    adminAdsListMenuController.selectedPage.value = currentPage;
                                    adminAdsListMenuController.getAdsData(sortBy: adminAdsListMenuController.selectedDropDownIndex.value);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
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
    required String location,
    required String status,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Dimens.eighty, right: Dimens.forty, top: Dimens.twenty, bottom: Dimens.twenty),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: Dimens.fifteen),
              child: CommonWidgets.autoSizeText(
                text: task,
                textStyle: AppStyles.style14SemiBold.copyWith(
                  color: themeUtils.fontColorBlackWhiteSwitchColor,
                ),
                maxLines: 3,
                minFontSize: 8,
                maxFontSize: 14,
              ),
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
              text: location,
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
              padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.fourteen),
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
                      ? ColorValues.statusFontColorRed
                      : status == CustomStatus.pending
                          ? ColorValues.statusColorYellow
                          : status == CustomStatus.blocked
                              ? ColorValues.statusColorBlack
                              : ColorValues.statusColorGreen,
                  width: 1.2,
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
                          ? ColorValues.statusFontColorRed
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
                      text: AppUtility.capitalizeStatus(status),
                      textStyle: AppStyles.style14SemiBold.copyWith(
                        color: status == CustomStatus.rejected
                            ? ColorValues.statusFontColorRed
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
