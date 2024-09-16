import 'package:RatingRadar_app/modules/admin/admin_manager/admin_manager_controller.dart';
import 'package:RatingRadar_app/modules/admin/admin_manager/component/admin_all_manager_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../admin_ads_list_menu/components/admin_ads_list_custom_dropdown.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';
import '../component/add_manager_compoent.dart';

class AdminManagerView extends StatefulWidget {
  const AdminManagerView({super.key});

  @override
  State<AdminManagerView> createState() => _AdminManagerViewState();
}

class _AdminManagerViewState extends State<AdminManagerView> {
  final adminManagerController = Get.find<AdminManagerController>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ThemeColorsUtil themeUtils;

  @override
  void initState() {
    super.initState();
    print("----------------adminManagerControlle");
    adminManagerController.getManagerList(sortBy: adminManagerController.selectedDropDownIndex.value);
  }

  @override
  void dispose() {
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
                          padding:
                              EdgeInsets.only(bottom: Dimens.thirtyFive, right: Dimens.fortyFive, left: Dimens.thirtyFour, top: Dimens.twentyEight),
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
                                      text: 'managers'.tr,
                                      textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 16,
                                      maxFontSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: Dimens.ten),
                                    child: CommonWidgets.autoSizeText(
                                      text: 'all_managers'.tr,
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
                                      //pending add component.
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AddManagerCompoent();
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: Dimens.fifteen),
                                      child: Container(
                                        height: Dimens.thirtyEight,
                                        width: Dimens.oneHundredFiftyFive,
                                        decoration:
                                            BoxDecoration(color: themeUtils.primaryColorSwitch, borderRadius: BorderRadius.circular(Dimens.twenty)),
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
                                                'add_managers'.tr,
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
                                        controller: adminManagerController.searchController,
                                        onChange: (value) {
                                          // search
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            if (value != null && value.isNotEmpty) {
                                              // Fetch the user list with the current sort order and the entered search term
                                              adminManagerController.getManagerList(
                                                // The number of users per page
                                                sortBy: adminManagerController.selectedDropDownIndex.value, // Sort by field
                                                searchTerm: value, // The search term from input
                                              );
                                            } else {
                                              // If the search term is cleared, fetch the user list without any search term
                                              adminManagerController.getManagerList(
                                                sortBy: adminManagerController.selectedDropDownIndex.value,
                                                searchTerm: null, // No search term, fetch all data
                                              );
                                            }
                                          });
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
                                      dropDownItems: adminManagerController.adsListDropDownList,
                                      selectedItem: adminManagerController.adsListDropDownList[adminManagerController.selectedDropDownIndex.value],
                                      onItemSelected: (index) {
                                        adminManagerController.selectedDropDownIndex.value = index;
                                        adminManagerController.getManagerList(sortBy: adminManagerController.selectedDropDownIndex.value);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        AdminAllManagerComponent(
                          managerList: adminManagerController.managerList.value,
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
