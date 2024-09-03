import 'package:RatingRadar_app/common/cached_network_image.dart';
import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/dimens.dart';
import '../../../../utility/theme_colors_util.dart';
import '../model/user_ads_list_data_model.dart';

class UserAdViewComponent extends StatelessWidget {
  final ThemeColorsUtil themeColorUtil;
  final UserAdsListDataModel userAdsListDataModel;
  final Function()? onViewButtonTap;

  const UserAdViewComponent({super.key, required this.themeColorUtil, required this.userAdsListDataModel, this.onViewButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimens.twelve, bottom: Dimens.eighteen, left: Dimens.fourteen, right: Dimens.fourteen),
      margin: EdgeInsets.only(top: Dimens.twenty),
      width: Dimens.threeHundredTwenty,
      decoration: BoxDecoration(
        color: themeColorUtil.darkGrayWhiteSwitchColor,
        borderRadius: BorderRadius.circular(Dimens.twentyEight),
        boxShadow: [
          BoxShadow(
            color: themeColorUtil.blackPrimaryBlueSwitchColor.withOpacity(0.25),
            offset: const Offset(2, 2),
            blurRadius: 14,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.twentyThree),
            child: NxNetworkImage(
              imageUrl: userAdsListDataModel.imageUrl?[0] ?? '',
              width: Dimens.twoHundredNinety,
              height: Dimens.oneHundredNinety,
              imageFit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.nine),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimens.sevenTeen, bottom: Dimens.four),
                  child: CommonWidgets.autoSizeText(
                    text: userAdsListDataModel.adName,
                    textStyle: AppStyles.style17Normal.copyWith(fontWeight: FontWeight.w500, color: themeColorUtil.whiteBlackSwitchColor),
                    minFontSize: 10,
                    maxFontSize: 17,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Dimens.nine),
                  child: CommonWidgets.autoSizeText(
                    text: userAdsListDataModel.byCompany,
                    textStyle: AppStyles.style13Normal.copyWith(color: themeColorUtil.whiteBlackSwitchColor),
                    minFontSize: 7,
                    maxFontSize: 13,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.nine),
                  child: CommonWidgets.autoSizeText(
                    text: userAdsListDataModel.adContent,
                    textStyle: AppStyles.style13Normal.copyWith(color: themeColorUtil.whiteBlackSwitchColor.withOpacity(0.50)),
                    minFontSize: 13,
                    maxLines: 2,
                    maxFontSize: 13,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.eighteen, bottom: Dimens.eleven),
                  child: Divider(
                    color: themeColorUtil.lightGrayC4SwitchColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onViewButtonTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Dimens.eleven, horizontal: Dimens.eighteen),
                        decoration: BoxDecoration(
                          color: themeColorUtil.primaryColorSwitch,
                          borderRadius: BorderRadius.circular(Dimens.oneHundredFifteen),
                        ),
                        child: Text(
                          'view'.tr,
                          style: AppStyles.style13semiBold.copyWith(color: themeColorUtil.blackWhiteSwitchColor),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidgets.autoSizeText(
                            text: 'task_price'.tr,
                            textStyle: AppStyles.style9SemiBold.copyWith(color: themeColorUtil.whiteBlackSwitchColor),
                            minFontSize: 9,
                            maxFontSize: 9,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Dimens.three),
                            child: CommonWidgets.autoSizeText(
                              text: "${'Rs'.tr}${userAdsListDataModel.adPrice}",
                              textStyle: AppStyles.style17Normal.copyWith(color: themeColorUtil.primaryColorSwitch, fontWeight: FontWeight.w600),
                              minFontSize: 12,
                              maxFontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
