import 'dart:ui';

import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';

class AdminBlockAdReasonComponent {
  static void adminBlockAdReasonDialogue({
    required BuildContext context,
    required ThemeColorsUtil themeUtils,
    required Function() onClose,
    required Function(String reasonText) onSubmit,
    List<TextInputFormatter>? inputFormatters,
    required int maxLines,
    hintText,
  }) async {
    TextEditingController controller = TextEditingController();
    Get.dialog(
      barrierColor: ColorValues.transparent,
      Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              Dimens.eighty, // minus header height
          width: (MediaQuery.of(context).size.width) -
              Dimens.twoHundredEighty, // minus drawer width
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Positioned(
                left: Dimens.threeHundredTwenty,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height - Dimens.eighty,
                    width: MediaQuery.of(context).size.width -
                        Dimens.threeHundredTwenty,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  // height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: themeUtils.blackWhiteSwitchColor,
                    border: Border.all(
                        color: themeUtils.primaryColorSwitch,
                        width: Dimens.one),
                    borderRadius: BorderRadius.circular(Dimens.twenty),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimens.twenty,
                        bottom: Dimens.twelve,
                        right: Dimens.twentySix,
                        left: Dimens.twentySix),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidgets.autoSizeText(
                            text: 'enter_reason_for_blocking_ad'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.ten),
                          child: CustomTextField(
                            controller: controller,
                            hintText: hintText,
                            maxLines: maxLines,
                            inputFormatters: inputFormatters,
                            borderSide: BorderSide(
                                color: themeUtils.adsTextFieldBorderColor),
                            fillColor: ColorValues.transparent,
                            hintStyle: const TextStyle(
                                color: ColorValues.lightGrayColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.ten),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomButton(
                                btnText: 'Cancel',
                                onTap: () {
                                  RouteManagement.goToBack();
                                },
                                isShowShadow: false,
                                borderRadius:
                                    BorderRadius.circular(Dimens.twenty),
                                contentPadding: EdgeInsets.only(
                                    top: Dimens.ten,
                                    bottom: Dimens.ten,
                                    left: Dimens.twentyFour,
                                    right: Dimens.twentyFour),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: Dimens.fifteen),
                                child: CustomButton(
                                  btnText: 'Submit',
                                  isShowShadow: false,
                                  onTap: () => onSubmit(controller.text),
                                  borderRadius:
                                      BorderRadius.circular(Dimens.twenty),
                                  btnTextColor:
                                      themeUtils.blackWhiteSwitchColor,
                                  contentPadding: EdgeInsets.only(
                                      top: Dimens.ten,
                                      bottom: Dimens.ten,
                                      left: Dimens.twentyFour,
                                      right: Dimens.twentyFour),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
