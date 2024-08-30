import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';

class CustomPaginationWidget extends StatelessWidget {
  final int totalCount;
  int currentPage;
  final Function(int currentPage) onPageChanged;
  late int totalPages;

  CustomPaginationWidget({
    super.key,
    required this.totalCount,
    required this.currentPage,
    required this.onPageChanged,
  }) {
    totalPages = (totalCount / itemsPerPage).ceil();
  }

  int itemsPerPage = 9;
  int pageRange = 4;

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);

    // Function to calculate start and end indexes
    int calculateStartIndex(int page) => ((page - 1) * itemsPerPage + 1).toInt();
    int calculateEndIndex(int page) {
      int endIndex = (page * itemsPerPage).toInt();
      return endIndex > totalCount ? totalCount.toInt() : endIndex;
    }

    // onLoad(calculateStartIndex(currentPage), calculateEndIndex(currentPage));
    // If total pages are less than or equal to the page range
    if (totalPages <= pageRange) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidgets.autoSizeText(
            // showing_data 1 to 9 of  256K entries
            text: "${'showing_data'.tr} ${calculateStartIndex(currentPage)} ${'to'.tr} ${calculateEndIndex(currentPage)} ${'of'.tr} $totalCount ${'entries'.tr}",
            textStyle: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.fontColorBlackWhiteSwitchColor,
            ),
            maxLines: 2,
            minFontSize: 8,
            maxFontSize: 14,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Previous Button
              InkWell(
                onTap: () {
                  if (currentPage > 1) {
                    currentPage--;
                    onPageChanged(currentPage);
                  }
                },
                child: Container(
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
              ),
              // Page Numbers
              ...List.generate(totalPages, (index) {
                int pageIndex = index + 1;
                return InkWell(
                  onTap: () {
                    currentPage = pageIndex;
                    onPageChanged(pageIndex);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimens.twelve),
                    padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.ten),
                    decoration: BoxDecoration(
                        color: pageIndex == currentPage ? themeUtils.primaryColorSwitch : themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
                    child: Text(
                      pageIndex.toString(),
                      style: AppStyles.style12Normal.copyWith(
                        fontWeight: FontWeight.w500,
                        color: pageIndex == currentPage ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor,
                      ),
                    ),
                  ),
                );
              }),
              // Next Button
              InkWell(
                onTap: () {
                  if (currentPage < totalPages) {
                    currentPage++;
                    onPageChanged(currentPage);
                  }
                },
                child: Container(
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
              ),
            ],
          ),
        ],
      );
    }
    // If total pages are greater than the page range
    else {
      int startPageIndex = (currentPage - 1) >= (totalPages - pageRange) ? (totalPages - pageRange + 1) : currentPage;
      int endPageIndex = startPageIndex + pageRange - 1;

      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Previous Button
          InkWell(
            onTap: () {
              if (currentPage > 1) {
                currentPage--;
                onPageChanged(currentPage);
              }
            },
            child: Container(
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
          ),
          // Page Numbers
          ...List.generate(
            endPageIndex - startPageIndex + 1,
            (index) {
              int pageIndex = startPageIndex + index;
              return InkWell(
                onTap: () {
                  currentPage = pageIndex;
                  onPageChanged(currentPage);
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimens.twelve),
                  padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.ten),
                  decoration: BoxDecoration(
                      color: pageIndex == currentPage ? themeUtils.primaryColorSwitch : themeUtils.darkGrayOfWhiteSwitchColor, borderRadius: BorderRadius.circular(Dimens.four)),
                  child: Text(
                    pageIndex.toString(),
                    style: AppStyles.style12Normal.copyWith(
                      fontWeight: FontWeight.w500,
                      color: pageIndex == currentPage ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor,
                    ),
                  ),
                ),
              );
            },
          ),
          // Ellipsis (`...`) and Last Page Button
          if (currentPage <= (totalPages - pageRange))
            Padding(
              padding: EdgeInsets.only(left: Dimens.twelve),
              child: Text(
                '...',
                style: AppStyles.style12Normal.copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w500),
              ),
            ),
          if (currentPage <= (totalPages - pageRange))
            InkWell(
              onTap: () {
                currentPage = totalPages;
                onPageChanged(currentPage);
              },
              child: Container(
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
            ),
          // Next Button
          InkWell(
            onTap: () {
              if (currentPage < totalPages) {
                currentPage++;
                onPageChanged(currentPage);
              }
            },
            child: Container(
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
          ),
        ],
      );
    }
  }
}
