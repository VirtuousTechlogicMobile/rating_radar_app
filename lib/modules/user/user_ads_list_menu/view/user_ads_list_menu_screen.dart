import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/modules/user/header/bindings/header_binding.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../components/ads_list_custom_dropdown.dart';
import '../user_ads_list_menu_controller.dart';

class UserAdsListMenuScreen extends StatefulWidget {
  const UserAdsListMenuScreen({super.key});

  @override
  State<UserAdsListMenuScreen> createState() => _UserAdsListMenuScreenState();
}

class _UserAdsListMenuScreenState extends State<UserAdsListMenuScreen> {
  final userAdsListMenuController = Get.find<UserAdsListMenuController>();
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
    HeaderBinding().dependencies();
    return HeaderView(
      isDashboardScreen: false,
      isAdsListScreen: true,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    ScrollController scrollController = ScrollController();
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.thirty),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.forty, top: Dimens.twentyEight),
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
                                text: 'all_customers'.tr,
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

                        /// custom dropdown
                        Obx(
                          () => AdsListCustomDropdown(
                            dropDownItems: userAdsListMenuController.adsListDropDownList,
                            selectedItem: userAdsListMenuController.adsListDropDownList[userAdsListMenuController.selectedDropDownIndex.value],
                            onItemSelected: (index) {
                              userAdsListMenuController.selectedDropDownIndex.value = index;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ads list layout
                  SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: (Dimens.screenWidth / 1.3) > 1500 ? Dimens.screenWidth / 1.2 : 1500,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: Dimens.fifty,
                            width: (Dimens.screenWidth / 1.3) > 1500 ? Dimens.screenWidth / 1.2 : 1500,
                            margin: EdgeInsets.symmetric(horizontal: Dimens.thirtyEight),
                            decoration: BoxDecoration(
                              color: themeUtils.darkGrayOfWhiteSwitchColor,
                              borderRadius: BorderRadius.circular(Dimens.twentyFive),
                            ),
                          ),
                          SizedBox(
                            width: (Dimens.screenWidth / 1.3) > 1500 ? Dimens.screenWidth / 1.2 : 1500,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimens.fifteen),
                              child: DataTable(
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: ColorValues.dividerGreyColor, width: 1))),
                                headingRowHeight: Dimens.fifty,
                                dataRowHeight: Dimens.seventy,
                                columns: [
                                  DataColumn(
                                    label: Padding(
                                      padding: EdgeInsets.only(left: Dimens.eighty),
                                      child: SizedBox(
                                          height: Dimens.fifty,
                                          child: Text(
                                            'task'.tr,
                                            style: AppStyles.style14SemiBold.copyWith(
                                              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                            ),
                                          )),
                                    ),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'company'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'email'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'location'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'date'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'task_price'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                        height: Dimens.fifty,
                                        child: Text(
                                          'status'.tr,
                                          style: AppStyles.style14SemiBold.copyWith(
                                            color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                                          ),
                                        )),
                                  ),
                                ],
                                rows: [
                                  dataRowWidget(
                                    task: 'Jane Cooper',
                                    company: 'Microsoft',
                                    email: 'jane@microsoft.com',
                                    location: 'United States',
                                    date: '11-11-1111',
                                    price: 'Rs.100',
                                    status: 'ApprovedApproved',
                                  ),
                                  dataRowWidget(
                                    task: 'Jane Cooper',
                                    company: 'Microsoft',
                                    email: 'jane@microsoft.com',
                                    location: 'United States',
                                    date: '11-11-1111',
                                    price: 'Rs.100',
                                    status: 'ApprovedApproved',
                                  ),
                                  dataRowWidget(
                                    task: 'Jane Cooper',
                                    company: 'Microsoft',
                                    email: 'jane@microsoft.com',
                                    location: 'United States',
                                    date: '11-11-1111',
                                    price: 'Rs.100',
                                    status: 'ApprovedApproved',
                                  ),
                                ],
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
          ),
        );
      }),
    );
  }

  DataRow dataRowWidget({required String task, required String company, required String email, required location, required date, required price, required status}) {
    return DataRow(
      cells: [
        DataCell(Padding(
          padding: EdgeInsets.only(left: Dimens.eighty),
          child: Text(
            task,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        )),
        DataCell(
          Text(
            company,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
        DataCell(
          Text(
            email,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
        DataCell(
          Text(
            location,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
        DataCell(
          Text(
            date,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
        DataCell(
          Text(
            price,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        ),
        DataCell(
          Text(
            status,
            style: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          ),
        )
      ],
    );
  }
}
