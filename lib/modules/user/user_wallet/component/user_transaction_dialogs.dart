import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/helper/validators.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/custom_radio_button.dart';
import '../../../../constant/dimens.dart';

class UserTransactionDialogs {
  static void showDepositDialog({
    required BuildContext context,
    required Function() onClose,
    required Function() onConfirm,
    required Function(int selectedPaymentOption) onChangePaymentOption,
    required TextEditingController amountController,
  }) {
    final themeUtils = ThemeColorsUtil(context);
    ValueNotifier<int?> selectedPaymentType = ValueNotifier(null);
    Get.dialog(
      barrierColor: ColorValues.transparent,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.fifty)),
        elevation: 0,
        content: Container(
          padding: EdgeInsets.only(bottom: Dimens.fortyFive, top: Dimens.thirty, left: Dimens.thirtyEight, right: Dimens.thirtyEight),
          width: MediaQuery.of(context).size.width / 3.3,
          decoration: BoxDecoration(
            color: themeUtils.drawerBgWhiteSwitchColor,
            borderRadius: BorderRadius.circular(Dimens.forty),
            boxShadow: [
              BoxShadow(
                color: ColorValues.blackColor.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: themeUtils.whiteBlackSwitchColor,
                      ),
                    ),
                  ),
                  Text(
                    'deposit'.tr,
                    style: AppStyles.style35SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimens.twenty, right: Dimens.twenty, top: Dimens.forty, bottom: Dimens.fifteen),
                child: Text(
                  'amount'.tr,
                  style: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                ),
              ),
              CustomTextField(
                controller: amountController,
                contentPadding: EdgeInsets.symmetric(vertical: Dimens.fifteen, horizontal: Dimens.thirty),
                maxLines: 1,
                borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                borderRadius: BorderRadius.circular(Dimens.thirty),
                hintText: 'amount'.tr,
                hintStyle: AppStyles.style16Light.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                fillColor: themeUtils.drawerBgWhiteSwitchColor,
                length: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(Validators.numberPatternWithPoint)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimens.forty),
                child: Text(
                  'select_payment_option'.tr,
                  style: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: selectedPaymentType,
                builder: (context, value, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          onChangePaymentOption(0);
                          selectedPaymentType.value = 0;
                        },
                        child: CustomRadioButton(
                          isSelected: selectedPaymentType.value == 0,
                          labelText: 'bank_account'.tr,
                          labelPadding: EdgeInsets.symmetric(horizontal: Dimens.ten),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onChangePaymentOption(1);
                          selectedPaymentType.value = 1;
                        },
                        child: CustomRadioButton(
                          isSelected: selectedPaymentType.value == 1,
                          labelText: 'credit_card'.tr,
                          labelPadding: EdgeInsets.only(left: Dimens.ten),
                        ),
                      ),
                    ],
                  );
                },
              ),
              CustomButton(
                btnText: 'next'.tr,
                borderRadius: BorderRadius.circular(Dimens.thirty),
                contentPadding: EdgeInsets.symmetric(vertical: Dimens.fifteen),
                onTap: () {
                  if (amountController.text.trim().isEmpty) {
                    AppUtility.showSnackBar('please_enter_amount'.tr);
                  } else if (selectedPaymentType.value == null) {
                    AppUtility.showSnackBar('please_select_payment_type'.tr);
                  } else {
                    onConfirm();
                  }
                },
                margin: EdgeInsets.only(top: Dimens.forty),
              )
            ],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.linear,
      barrierDismissible: false,
    );
  }

  static void showWithdrawDialog({required BuildContext context, required Function() onClose, required Function() onConfirm, required TextEditingController amountController}) {
    final themeUtils = ThemeColorsUtil(context);
    Get.dialog(
      barrierColor: ColorValues.transparent,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.fifty)),
        elevation: 0,
        content: Container(
          padding: EdgeInsets.only(bottom: Dimens.thirty, top: Dimens.thirty, left: Dimens.forty, right: Dimens.forty),
          width: MediaQuery.of(context).size.width / 3.3,
          height: MediaQuery.of(context).size.width / 3.4,
          decoration: BoxDecoration(
            color: themeUtils.drawerBgWhiteSwitchColor,
            borderRadius: BorderRadius.circular(Dimens.forty),
            boxShadow: [
              BoxShadow(
                color: ColorValues.blackColor.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: themeUtils.whiteBlackSwitchColor,
                      ),
                    ),
                  ),
                  Text(
                    'withdraw'.tr,
                    style: AppStyles.style35SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimens.twenty, right: Dimens.twenty, top: Dimens.forty, bottom: Dimens.fifteen),
                child: Text(
                  'amount'.tr,
                  style: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimens.twenty, right: Dimens.twenty),
                child: CustomTextField(
                  controller: amountController,
                  contentPadding: EdgeInsets.symmetric(vertical: Dimens.fifteen, horizontal: Dimens.thirty),
                  maxLines: 1,
                  borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50), width: 1),
                  borderRadius: BorderRadius.circular(Dimens.thirty),
                  hintText: 'amount'.tr,
                  hintStyle: AppStyles.style16Light.copyWith(color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50)),
                  fillColor: themeUtils.drawerBgWhiteSwitchColor,
                  length: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimens.twenty, right: Dimens.twenty),
                child: CustomButton(
                  btnText: 'confirm'.tr,
                  borderRadius: BorderRadius.circular(Dimens.thirty),
                  contentPadding: EdgeInsets.symmetric(vertical: Dimens.fifteen),
                  onTap: onConfirm(),
                ),
              )
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
