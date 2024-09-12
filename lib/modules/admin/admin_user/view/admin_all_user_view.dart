import 'package:RatingRadar_app/modules/admin/admin_user/admin_all_user_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../admin_ads_list_menu/components/admin_ads_list_custom_dropdown.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';
import '../component/admin_all_users_company_component.dart';

class AdminAllUserView extends StatefulWidget {
  const AdminAllUserView({super.key});

  @override
  State<AdminAllUserView> createState() => _AdminAllUserViewState();
}

class _AdminAllUserViewState extends State<AdminAllUserView> {
  final adminAllUserController = Get.find<AdminAllUserController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ThemeColorsUtil themeUtils;

  @override
  void initState() {
    super.initState();
    adminAllUserController.scrollController1.addListener(adminAllUserController.updateScrollbar1Position);

    adminAllUserController.getUserList();
  }

  @override
  void dispose() {
    adminAllUserController.scrollController1.removeListener(adminAllUserController.updateScrollbar1Position);
    adminAllUserController.scrollController1.dispose();

    super.dispose();
  }

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
      isAdsListScreen: false,
    );
  }

  Widget adminScreenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              margin: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirteen, bottom: Dimens.fortyFive, top: Dimens.thirtyEight),
              padding: EdgeInsets.only(bottom: Dimens.fortyFive, left: Dimens.twenty),
              decoration: BoxDecoration(
                color: themeUtils.drawerBgWhiteSwitchColor,
                borderRadius: BorderRadius.circular(Dimens.thirty),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                    blurRadius: 50,
                    color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
                  ),
                ],
              ),
              child: Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.thirty),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.thirtyFive, right: Dimens.fortyFive, left: Dimens.thirtyFour, top: Dimens.twentyEight),
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
                                      text: 'users'.tr,
                                      textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 16,
                                      maxFontSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: Dimens.ten),
                                    child: CommonWidgets.autoSizeText(
                                      text: 'all_user'.tr,
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
                                                'add_user'.tr,
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
                                  Padding(
                                    padding: EdgeInsets.only(right: Dimens.fifteen),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 8,
                                      child: CustomTextField(
                                        controller: adminAllUserController.searchController,
                                        onChange: (value) {
                                          // search
                                        },
                                        borderRadius: BorderRadius.circular(Dimens.twenty),
                                        fillColor: themeUtils.darkGrayOfWhiteSwitchColor,
                                        maxLines: 1,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'search'.tr,
                                        borderSide: BorderSide.none,
                                        hintStyle: AppStyles.style14Normal.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
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

                                  /// custom dropdown
                                  Obx(
                                    () => AdminAdsListCustomDropdown(
                                      dropDownItems: adminAllUserController.adsListDropDownList,
                                      selectedItem: adminAllUserController.adsListDropDownList[adminAllUserController.selectedDropDownIndex.value],
                                      onItemSelected: (index) {
                                        adminAllUserController.selectedDropDownIndex.value = index;
                                        // adminAllUserController.getAdsData(sortBy: adminAllUserController.selectedDropDownIndex.value);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        AdminAllUsersCompanyComponent(
                          listScrollController: adminAllUserController.scrollController1,
                          scrollBarTop: adminAllUserController.scrollbar1Top.value,
                          scrollBarHeight: adminAllUserController.scrollbar1Height.value,
                          onPanUpaDate: (DragUpdateDetails details) {
                            adminAllUserController.onScrollbarPan1Update(details);
                            adminAllUserController.update(); // Force UI update
                          },
                          userList: adminAllUserController.userList.value,
                          showScrollbar: (adminAllUserController.userList.value?.length ?? 0) > 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
