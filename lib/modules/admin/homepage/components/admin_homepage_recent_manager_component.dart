import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_manager_model.dart';
import 'package:flutter/material.dart';
import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';

class AdminHomepageRecentManagerComponent extends StatelessWidget {
  final AdminHomepageRecentManagerModel? adminHomepageRecentManagerModel;

  const AdminHomepageRecentManagerComponent({super.key, required this.adminHomepageRecentManagerModel});

  @override
  Widget build(BuildContext context) {
    final themeColorsUtil = ThemeColorsUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: themeColorsUtil.blackWhiteSwitchColor,
          boxShadow: [
            BoxShadow(spreadRadius: -1, blurRadius: 8, offset: const Offset(0, 2), color: themeColorsUtil.boxShadowContainerColor),
          ],
          border: Border.all(
            color: ColorValues.primaryColorBlue.withOpacity(0.15),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(Dimens.ten)),
      margin: EdgeInsets.only(right: Dimens.nineteen, left: Dimens.twentyFive, bottom: Dimens.eighteen),
      child: Padding(
        padding: EdgeInsets.all(Dimens.sixTeen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              if (adminHomepageRecentManagerModel?.imageUrl != null && adminHomepageRecentManagerModel?.imageUrl != '') {
                return ClipOval(
                  child: NxNetworkImage(
                    imageUrl: adminHomepageRecentManagerModel?.imageUrl ?? '',
                    width: Dimens.fortyEight,
                    height: Dimens.fortyEight,
                    imageFit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(
                  width: Dimens.fortyEight,
                  height: Dimens.fortyEight,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorValues.primaryColorBlue, // Background color for the circle
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    adminHomepageRecentManagerModel?.name.substring(0, 2).toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: Dimens.twenty, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.eight, left: Dimens.sixTeen),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: Dimens.eight),
                        child: CommonWidgets.autoSizeText(
                          text: adminHomepageRecentManagerModel?.name ?? '',
                          textStyle: AppStyles.style16Bold.copyWith(color: themeColorsUtil.cardTextColor),
                          minFontSize: 16,
                          maxFontSize: 16,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Flexible(
                      child: CommonWidgets.autoSizeText(
                        text: adminHomepageRecentManagerModel?.email ?? '',
                        textStyle: AppStyles.style14Normal.copyWith(color: themeColorsUtil.cardTextColor),
                        minFontSize: 10,
                        maxFontSize: 16,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.more_vert,
              color: themeColorsUtil.whiteBlackSwitchColor,
            ),
          ],
        ),
      ),
    );
  }
}
