import 'package:flutter/material.dart';

import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';

class CustomPaginationWidget extends StatelessWidget {
  final int totalCount;
  final int currentPage;
  final Function(int currentPage) onPageChanged;
  late int totalPages;
  int itemsPerPage = 9;
  int pageRange = 4;

  CustomPaginationWidget({
    super.key,
    required this.totalCount,
    required this.currentPage,
    required this.onPageChanged,
  }) {
    totalPages = (totalCount / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.nine),
          decoration: BoxDecoration(color: themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
          child: Text(
            '<',
            style: AppStyles.style14Normal.copyWith(
              fontWeight: FontWeight.w500,
              color: themeUtils.whiteBlackSwitchColor,
            ),
          ),
        ),
        ...List.generate(
          pageRange < totalPages ? pageRange : totalPages,
          (index) {
            int pageIndex = currentPage + (pageRange - 1) > totalPages ? (totalPages - (pageRange - 1)) + index : currentPage + index;
            return InkWell(
              onTap: () {
                onPageChanged(pageIndex);
              },
              child: Container(
                margin: EdgeInsets.only(left: Dimens.twelve),
                padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.ten),
                decoration: BoxDecoration(
                    color: pageIndex == currentPage ? themeUtils.primaryColorSwitch : themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
                child: Text(
                  currentPage + (pageRange - 1) > totalPages ? ((totalPages - (pageRange - 1)) + index).toString() : (currentPage + index).toString(),
                  style: AppStyles.style12Normal.copyWith(
                    fontWeight: FontWeight.w500,
                    color: pageIndex == currentPage ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor,
                  ),
                ),
              ),
            );
          },
        ),
        if (currentPage + (pageRange - 1) < totalPages)
          Padding(
            padding: EdgeInsets.only(left: Dimens.twelve),
            child: Text(
              '...',
              style: AppStyles.style12Normal.copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w500),
            ),
          ),
        if (currentPage + (pageRange - 1) < totalPages)
          Container(
            margin: EdgeInsets.only(left: Dimens.twelve),
            padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.ten),
            decoration: BoxDecoration(color: themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
            child: Text(
              totalPages.toString(),
              style: AppStyles.style12Normal.copyWith(
                fontWeight: FontWeight.w500,
                color: themeUtils.whiteBlackSwitchColor,
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(left: Dimens.twelve),
          padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.nine),
          decoration: BoxDecoration(color: themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
          child: Text(
            '>',
            style: AppStyles.style14Normal.copyWith(
              fontWeight: FontWeight.w500,
              color: themeUtils.whiteBlackSwitchColor,
            ),
          ),
        ),
      ],
    );
  }
}
