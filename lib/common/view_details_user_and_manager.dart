import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constant/dimens.dart';
import '../constant/styles.dart';
import '../routes/route_management.dart';
import '../utility/theme_colors_util.dart';
import 'cached_network_image.dart';
import 'common_widgets.dart';

class ViewDetailsUserAndManager extends StatelessWidget {
  final String title;
  final String? name;
  final String? imageUrl;
  final String? userOrManager;
  final String? panNumber;
  final String? city;
  final String? state;
  final String? gender;
  final String? phone;
  final String? email;
  final String? gstNumber;

  const ViewDetailsUserAndManager({
    super.key,
    this.name,
    this.imageUrl,
    this.userOrManager,
    this.panNumber,
    this.city,
    this.state,
    this.gender,
    this.phone,
    this.email,
    required this.title,
    this.gstNumber,
  });

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeUtils = ThemeColorsUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: themeUtils.blackWhiteSwitchColor,
        borderRadius: BorderRadius.circular(Dimens.thirty),
        border: Border.all(color: themeUtils.primaryColorSwitch),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimens.fifty, horizontal: Dimens.eightyFive),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ClipOval(
                    child: NxNetworkImage(
                      // imageUrl: '',
                      imageUrl: imageUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      height: Dimens.eightyFive,
                      width: Dimens.eightyFive,
                      imageFit: BoxFit.cover,
                    ),
                  ),
                  Dimens.boxHeight25,
                  CommonWidgets.autoSizeText(
                    text: name ?? 'N/A',
                    textStyle: AppStyles.style20Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                    minFontSize: 11,
                    maxFontSize: 20,
                  ),
                  CommonWidgets.autoSizeText(
                    text: userOrManager ?? 'N/A',
                    textStyle: AppStyles.style20Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                    minFontSize: 11,
                    maxFontSize: 20,
                  ),
                  CommonWidgets.autoSizeText(
                    text: "GSTIN:${gstNumber ?? 'No Data'}",
                    textStyle: AppStyles.style14Normal.copyWith(
                      color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                    ),
                    minFontSize: 8,
                    maxFontSize: 14,
                  ),
                ],
              ),
              Container(
                width: 2,
                height: MediaQuery.sizeOf(context).height * 0.3,
                color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.autoSizeText(
                    text: title ?? '',
                    textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                    minFontSize: 12,
                    maxFontSize: 24,
                  ),
                  Dimens.boxHeight15,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.panIcon,
                              color: themeUtils.whiteBlackSwitchColor,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " ${'pan_number'.tr}",
                              textStyle: AppStyles.style21Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " : $panNumber" ?? 'No Data',
                              textStyle: AppStyles.style21Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                          ],
                        ),
                        Dimens.boxHeight15,
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.locationIcon,
                              color: themeUtils.whiteBlackSwitchColor,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " ${'location'.tr}",
                              textStyle: AppStyles.style21Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " : $city,$state" ?? 'No Data',
                              textStyle: AppStyles.style21Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                          ],
                        ),
                        Dimens.boxHeight15,
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.genderIcon,
                              color: themeUtils.whiteBlackSwitchColor,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " ${'gender'.tr}",
                              textStyle: AppStyles.style21Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " : $gender" ?? 'No Data',
                              textStyle: AppStyles.style21Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 22,
                            ),
                          ],
                        ),
                        Dimens.boxHeight15,
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.phoneIcon,
                              color: themeUtils.whiteBlackSwitchColor,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " ${'phone'.tr}",
                              textStyle: AppStyles.style21Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " : $phone" ?? 'No Data',
                              textStyle: AppStyles.style21Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                          ],
                        ),
                        Dimens.boxHeight15,
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.emailIcon,
                              color: themeUtils.whiteBlackSwitchColor,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " ${'email'.tr}",
                              textStyle: AppStyles.style21Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                            CommonWidgets.autoSizeText(
                              text: " : $email" ?? 'No Data',
                              textStyle: AppStyles.style21Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 11,
                              maxFontSize: 21,
                            ),
                          ],
                        ),
                        Dimens.boxHeight35,
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Dimens.boxWidth30,
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeUtils.primaryColorSwitch,
                            borderRadius: BorderRadius.circular(Dimens.thirty),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.twentyFive),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgAssets.drawerWalletIcon,
                                color: themeUtils.whiteBlackSwitchColor,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: themeUtils.whiteBlackSwitchColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Dimens.boxWidth15,
                      CustomButton(
                        btnText: 'cancle'.tr,
                        borderRadius: BorderRadius.circular(Dimens.hundred),
                        contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.twentyFour),
                        btnTextColor: themeUtils.whiteBlackSwitchColor,
                        onTap: () {
                          RouteManagement.goToBack();
                        },
                      ),
                      Dimens.boxWidth15,
                      CustomButton(
                        btnText: 'edit'.tr,
                        borderRadius: BorderRadius.circular(Dimens.hundred),
                        contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.thirtyEight),
                        btnTextColor: themeUtils.whiteBlackSwitchColor,
                      ),
                      Dimens.boxWidth15,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
