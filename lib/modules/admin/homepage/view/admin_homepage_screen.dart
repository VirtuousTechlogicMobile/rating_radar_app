import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/modules/admin/admin_header/view/admin_header_view.dart';
import 'package:RatingRadar_app/modules/admin/drawer/view/admin_drawer_view.dart';
import 'package:RatingRadar_app/modules/admin/homepage/admin_homepage_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/responsive.dart';
import '../components/admin_custom_dropdown.dart';
import '../components/admin_homepage_recent_user_component.dart';
import '../components/admin_homepage_view_component.dart';
import '../model/admin_homepage_ads_view_model.dart';

class AdminHomepageScreen extends StatefulWidget {
  AdminHomepageScreen({super.key});

  @override
  State<AdminHomepageScreen> createState() => _AdminHomepageScreenState();
}

class _AdminHomepageScreenState extends State<AdminHomepageScreen> {
  final AdminHomepageController adminHomePageController = Get.find<AdminHomepageController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    adminHomePageController.scrollController1.addListener(adminHomePageController.updateScrollbar1Position);

    adminHomePageController.scrollController2.addListener(adminHomePageController.updateScrollbar2Position);

    adminHomePageController.getUserList();
    adminHomePageController.getCompanyList();
  }

  @override
  void dispose() {
    adminHomePageController.scrollController1.removeListener(adminHomePageController.updateScrollbar1Position);
    adminHomePageController.scrollController1.dispose();

    adminHomePageController.scrollController2.removeListener(adminHomePageController.updateScrollbar2Position);
    adminHomePageController.scrollController2.dispose();
    super.dispose();
  }

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
                adminScreenMainLayout(themeUtils: themeUtils),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget adminHeader() {
    return AdminHeaderView(
      isDashboardScreen: true,
    );
  }

  Widget adminScreenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.sixtySeven, vertical: Dimens.sixty),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
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
                  Obx(() => AdminCustomDropdown(
                        dropDownItems: adminHomePageController.adminDropdownItemList,
                        selectedItem: adminHomePageController.adminDropdownItemList[adminHomePageController.selectedDropdownItemIndex.value],
                        onItemSelected: (index) async {
                          adminHomePageController.selectedDropdownItemIndex.value = index;
                          // await adminHomePageController.getAdsList();
                        },
                      )),
                ],
              ),
              // Grid Section
              Container(
                // padding: Dimens.edgeInsetsLeftRight67,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double spacing = _calculateGridSpacing(constraints.maxWidth, Dimens.twoHundredTwenty);

                    return Wrap(
                      spacing: spacing,
                      runSpacing: Dimens.sixTeen, // Vertical spacing
                      children: List.generate(
                        4,
                        (index) => AdminHomepageViewComponent(
                          themeUtils: themeUtils,
                          index: index,
                          listLength: 4,
                          viewsModel: AdminHomepageAdsViewsDataModel(totalViews: 1265, isMarketValueUp: true, marketValuePercentage: 11.02),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Members Section
              Padding(
                padding: EdgeInsets.only(top: Dimens.twentySix, bottom: Dimens.nine),
                child: CommonWidgets.autoSizeText(
                  text: 'members'.tr,
                  textStyle: AppStyles.style24Normal.copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w600),
                  minFontSize: 15,
                  maxFontSize: 24,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidgets.autoSizeText(
                    text: 'recent_joined_members'.tr,
                    textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                    minFontSize: 8,
                    maxFontSize: 14,
                  ),
                ],
              ),
              // Recent User/Company Section
              LayoutBuilder(builder: (context, constraints) {
                return Obx(
                  () => Flex(
                    direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
                    children: [
                      SizedBox(
                        width: Responsive.isDesktop(context) ? constraints.maxWidth / 2 : constraints.maxWidth,
                        child: AdminHomepageRecentUserComponent(
                          listScrollController: adminHomePageController.scrollController1,
                          scrollBarTop: adminHomePageController.scrollbar1Top.value,
                          scrollBarHeight: adminHomePageController.scrollbar1Height.value,
                          isUser: true,
                          onPanUpaDate: (DragUpdateDetails details) {
                            adminHomePageController.onScrollbarPan1Update(details);
                            adminHomePageController.update(); // Force UI update
                          },
                          userList: adminHomePageController.userList.value,
                          showScrollbar: (adminHomePageController.userList.value?.length ?? 0) > 3,
                        ),
                      ),
                      SizedBox(
                        width: Responsive.isDesktop(context) ? constraints.maxWidth / 2 : constraints.maxWidth,
                        child: AdminHomepageRecentUserComponent(
                          listScrollController: adminHomePageController.scrollController2,
                          scrollBarTop: adminHomePageController.scrollbar2Top.value,
                          scrollBarHeight: adminHomePageController.scrollbar2Height.value,
                          isUser: false,
                          onPanUpaDate: (DragUpdateDetails details) {
                            adminHomePageController.onScrollbarPan2Update(details);
                            adminHomePageController.update(); // Force UI update
                          },
                          userList: adminHomePageController.companyList.value,
                          showScrollbar: (adminHomePageController.userList.value?.length ?? 0) > 3,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateGridSpacing(double maxWidth, double itemWidth) {
    int itemCount = (maxWidth / itemWidth).floor();
    double spacing = ((maxWidth - (itemCount * itemWidth)) / (itemCount - 1));
    return spacing > 0 ? spacing : Dimens.sixTeen;
  }
}
