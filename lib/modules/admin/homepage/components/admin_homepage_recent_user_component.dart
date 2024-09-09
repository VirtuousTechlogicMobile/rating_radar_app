import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';
import 'admin_homepage_recent_user_company_components.dart';

class AdminHomepageRecentUserComponent extends StatelessWidget {
  final ScrollController listScrollController;
  final double scrollBarTop;
  final double scrollBarHeight;
  final bool isUser;
  final List<AdminHomepageRecentUserCompanyModel>? userList;
  final Function(DragUpdateDetails) onPanUpaDate;

  const AdminHomepageRecentUserComponent({
    super.key,
    required this.listScrollController,
    required this.scrollBarHeight,
    required this.scrollBarTop,
    required this.isUser,
    required this.userList,
    required this.onPanUpaDate,
  });

  // final adminHomepageController = Get.find<AdminHomepageController>();
  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Container(
      height: Dimens.screenHeight / 2,
      margin: EdgeInsets.only(
        top: Dimens.fifteen,
        right: Dimens.forty,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: themeUtils.darkGrayWhiteSwitchColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimens.twentyFour),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidgets.autoSizeText(
                  text: isUser ? 'recent_user'.tr : 'recent_company'.tr,
                  textStyle: AppStyles.style16Bold.copyWith(
                    color: themeUtils.blackColorWithWhiteColor,
                  ),
                  minFontSize: 8,
                  maxFontSize: 16,
                ),
                CommonWidgets.autoSizeText(
                  text: 'see_all'.tr,
                  textStyle: AppStyles.style12Bold.copyWith(
                    color: themeUtils.primaryColorSwitch,
                  ),
                  minFontSize: 8,
                  maxFontSize: 12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      controller: listScrollController,
                      child: Column(
                        children: List.generate(
                          userList?.length ?? 0,
                          (index) {
                            return AdminHomepageRecentUserCompanyComponents(
                              adminHomepageRecentUserCompanyModel:
                                  userList?[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Dimens.sevenTeen),
                  child: Stack(
                    children: [
                      VerticalDivider(
                        width: Dimens.ten,
                        thickness: Dimens.two,
                        color: themeUtils.whiteBlackSwitchColor,
                        // indent: Dimens.sixTeen,
                        endIndent: Dimens.sixTeen,
                      ),
                      Positioned(
                        right: 0,
                        top: scrollBarTop,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            onPanUpaDate(details);
                          },
                          child: Container(
                            width: Dimens.ten,
                            height: scrollBarHeight > Dimens.sixTeen
                                ? scrollBarHeight - Dimens.sixTeen
                                : 0, // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.four),
                              color: themeUtils.primaryColorSwitch,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
