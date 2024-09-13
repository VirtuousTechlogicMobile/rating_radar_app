import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';

import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../components/ads_list_custom_dropdown.dart';
import '../components/custom_pagination_widget.dart';
import '../user_ads_list_menu_controller.dart';

class UserAdsListMenuScreen extends StatelessWidget {
  final userAdsListMenuController = Get.find<UserAdsListMenuController>();

  UserAdsListMenuScreen({super.key}) {
    userAdsListMenuController.getAdsData(sortBy: userAdsListMenuController.selectedDropDownIndex.value);
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
          DrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                screenMainLayout(themeUtils: themeUtils),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return HeaderView(
      isDashboardScreen: false,
      isAdsListScreen: true,
      onSearch: (text) async {
        await Future.delayed(const Duration(milliseconds: 500));
        userAdsListMenuController.getAdsData(sortBy: userAdsListMenuController.selectedDropDownIndex.value, searchTerm: text);
      },
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
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
                            text: 'my_ads'.tr,
                            textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'ads'.tr,
                            textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 10,
                            maxFontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    /// custom dropdown
                    Obx(
                      () => AdsListCustomDropdown(
                        dropDownItems: userAdsListMenuController.adsListDropDownList,
                        selectedItem: userAdsListMenuController.adsListDropDownList[userAdsListMenuController.selectedDropDownIndex.value],
                        onItemSelected: (index) {
                          userAdsListMenuController.selectedDropDownIndex.value = index;
                          userAdsListMenuController.getAdsData(sortBy: userAdsListMenuController.selectedDropDownIndex.value);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// ads list layout
              Obx(
                () => Visibility(
                  visible: userAdsListMenuController.userSubmittedAdsList.isNotEmpty,
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
                                    userAdsListMenuController.userSubmittedAdsList.length,
                                    (index) {
                                      return MouseRegion(
                                        onEnter: (_) => userAdsListMenuController.isHoveredList[index].value = true,
                                        onExit: (_) => userAdsListMenuController.isHoveredList[index].value = false,
                                        child: InkWell(
                                          onTap: () {
                                            RouteManagement.goToUserSubmitAdScreen(adDocumentId: userAdsListMenuController.userSubmittedAdsList[index].adId);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: userAdsListMenuController.isHoveredList[index].value
                                                  ? themeUtils.darkGrayOfWhiteSwitchColor.withOpacity(0.5)
                                                  : Colors.transparent,
                                              border: userAdsListMenuController.isHoveredList[index].value
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
                                            child: Column(
                                              children: [
                                                customTableRow(
                                                  task: userAdsListMenuController.userSubmittedAdsList[index].taskName,
                                                  company: userAdsListMenuController.userSubmittedAdsList[index].company,
                                                  email: userAdsListMenuController.userSubmittedAdsList[index].email,
                                                  date: userAdsListMenuController.parseDate(userAdsListMenuController.userSubmittedAdsList[index].date),
                                                  price: userAdsListMenuController.userSubmittedAdsList[index].adPrice.toString(),
                                                  status: userAdsListMenuController.userSubmittedAdsList[index].adStatus,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
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
                                  currentPage: userAdsListMenuController.selectedPage.value,
                                  totalCount: userAdsListMenuController.totalUserSubmittedAds.value,
                                  onPageChanged: (currentPage) {
                                    userAdsListMenuController.selectedPage.value = currentPage;
                                    userAdsListMenuController.getAdsData(sortBy: userAdsListMenuController.selectedDropDownIndex.value);
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
            'company'.tr,
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
                      ? ColorValues.statusColorRed
                      : status == CustomStatus.pending
                          ? ColorValues.statusColorYellow
                          : status == CustomStatus.blocked
                              ? ColorValues.statusColorBlack
                              : ColorValues.statusColorBlack,
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
                      text: AppUtility.capitalizeStatus(status),
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
