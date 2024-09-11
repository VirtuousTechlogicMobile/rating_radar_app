import 'dart:ui';

import 'package:RatingRadar_app/common/cached_network_image.dart';
import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';

class UserEditProfileDialogComponent {
  static void userEditProfileDialog({
    required BuildContext context,
    required ThemeColorsUtil themeUtils,
    required Function() onClose,
    required Function() onChange,
    required Function() onRemove,
    required String imageUrl,
  }) async {
    Get.dialog(
      barrierColor: ColorValues.transparent,
      Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - Dimens.eighty, // minus header height
          width: (MediaQuery.of(context).size.width - Dimens.threeHundredTwenty) - Dimens.twoHundredEighty, // minus drawer width
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Positioned(
                left: Dimens.threeHundredTwenty,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height - Dimens.eighty,
                    width: MediaQuery.of(context).size.width - Dimens.threeHundredTwenty,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              AlertDialog(
                alignment: Alignment.center,
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.fifty)),
                elevation: 0,
                content: Container(
                  padding: EdgeInsets.only(bottom: Dimens.thirty, top: Dimens.twentySix, left: Dimens.twentyFive, right: Dimens.twentyFive),
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    color: themeUtils.drawerBgWhiteSwitchColor,
                    borderRadius: BorderRadius.circular(Dimens.nineteen),
                    boxShadow: [
                      BoxShadow(
                        color: ColorValues.blackColor.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 14,
                        offset: const Offset(1.30, 1.30),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () => onClose(),
                              child: CommonWidgets.fromSvg(
                                svgAsset: SvgAssets.leftArrowIcon,
                                height: Dimens.eighteen,
                                width: Dimens.nine,
                                boxFit: BoxFit.fill,
                                color: themeUtils.whiteBlackSwitchColor,
                              ),
                            ),
                          ),
                          Text(
                            'profile_picture'.tr,
                            style: AppStyles.style24SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                          ),
                          const SizedBox.shrink(),
                        ],
                      ),
                      ClipOval(
                        child: NxNetworkImage(
                          imageUrl: imageUrl.isNotEmpty ? imageUrl : StringValues.noProfileImageUrl,
                          height: Dimens.oneHundredSixtySeven,
                          width: Dimens.oneHundredSixtySeven,
                          imageFit: BoxFit.cover,
                        ),
                      ).marginOnly(top: Dimens.fortyFive, bottom: Dimens.forty),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CustomButton(
                              btnText: 'Change',
                              onTap: () => onChange(),
                              borderRadius: BorderRadius.circular(Dimens.twenty),
                              btnTextColor: themeUtils.blackWhiteSwitchColor,
                              contentPadding: EdgeInsets.symmetric(vertical: Dimens.eight),
                              margin: EdgeInsets.only(right: Dimens.eight),
                            ),
                          ),
                          Flexible(
                            child: CustomButton(
                              btnText: 'Remove',
                              onTap: () {
                                if (imageUrl.isNotEmpty) {
                                  onRemove();
                                }
                              },
                              borderRadius: BorderRadius.circular(Dimens.twenty),
                              buttonColor: imageUrl.isNotEmpty ? themeUtils.primaryColorSwitch : themeUtils.primaryColorSwitch.withOpacity(0.50),
                              isShowShadow: false,
                              btnTextColor: imageUrl.isNotEmpty ? themeUtils.blackWhiteSwitchColor : themeUtils.blackWhiteSwitchColor.withOpacity(0.50),
                              contentPadding: EdgeInsets.symmetric(vertical: Dimens.eight),
                              margin: EdgeInsets.only(left: Dimens.eight),
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: Dimens.forty),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.linear,
      barrierDismissible: false,
    );
  }
}
