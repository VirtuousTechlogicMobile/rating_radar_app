import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import 'package:flutter/material.dart';

import '../../../../constant/dimens.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../homepage/components/admin_homepage_recent_user_company_components.dart';

class AdminAllUsersCompanyComponent extends StatelessWidget {
  final ScrollController listScrollController;
  final double scrollBarTop;
  final double scrollBarHeight;
  final Function(DragUpdateDetails) onPanUpaDate;
  final List<AdminHomepageRecentUserCompanyModel>? userList;
  final bool showScrollbar; // New parameter

  const AdminAllUsersCompanyComponent({
    super.key,
    required this.listScrollController,
    required this.scrollBarTop,
    required this.scrollBarHeight,
    required this.onPanUpaDate,
    required this.userList,
    required this.showScrollbar,
  });

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: listScrollController,
              child: Column(
                children: List.generate(
                  userList?.length ?? 0,
                  (index) {
                    return AdminHomepageRecentUserCompanyComponents(
                      adminHomepageRecentUserCompanyModel: userList?[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ), // Show scrollbar conditionally
        /* Padding(
          padding: EdgeInsets.only(right: Dimens.sevenTeen),
          child: Stack(
            children: [
              VerticalDivider(
                width: Dimens.ten,
                thickness: Dimens.two,
                color: themeUtils.whiteBlackSwitchColor,
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
                    height: scrollBarHeight > Dimens.sixTeen ? scrollBarHeight - Dimens.sixTeen : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.four),
                      color: themeUtils.primaryColorSwitch,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}
