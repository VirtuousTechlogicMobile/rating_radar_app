import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/modules/user/user_payment_method_setting/components/user_payment_components.dart';
import 'package:RatingRadar_app/modules/user/user_payment_method_setting/user_payment_method_setting_controller.dart';
import 'package:RatingRadar_app/modules/user/user_signup/model/user_signup_model.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../../user_settings_menu_drawer/view/user_settings_menu_drawer_view.dart';

class UserPaymentMethodSettingScreen extends StatelessWidget {
  UserPaymentMethodSettingScreen({super.key});

  final userPaymentMethodSettingController = Get.find<UserPaymentMethodSettingController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Scaffold(
      backgroundColor: themeUtils.screensBgSwitchColor,
      body: Row(
        children: [
          DrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                Expanded(child: screenMainLayout(themeUtils: themeUtils)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return HeaderView(
      isDashboardScreen: false,
      isAdsListScreen: false,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: UserSettingsMenuDrawerView(),
            ).marginOnly(top: Dimens.twenty, left: Dimens.thirty, bottom: Dimens.forty),
            Expanded(
              child: Container(
                height: constraints.maxHeight,
                margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.fifteen, right: Dimens.twentyFour, bottom: Dimens.forty),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.thirty),
                  color: themeUtils.deepBlackWhiteSwitchColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 60,
                      spreadRadius: 0,
                      color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.thirty),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimens.twentyEight, left: Dimens.twentyEight),
                        child: CommonWidgets.autoSizeText(
                          text: 'payment_method'.tr,
                          textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                          minFontSize: 16,
                          maxFontSize: 24,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimens.twentyEight, right: Dimens.fifty, bottom: Dimens.twentyEight),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonWidgets.autoSizeText(
                                text: 'bank_accounts'.tr,
                                textStyle: AppStyles.style21SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                minFontSize: 8,
                                maxFontSize: 21,
                              ).marginOnly(top: Dimens.thirty, bottom: Dimens.thirteen),

                              /// banks details
                              UserPaymentComponents.userBankAccountCardLayout(
                                themeUtils: themeUtils,
                                userBankData: UserBankData(
                                  bankName: 'Axis Bank',
                                  ifscCode: '',
                                  accNumber: AppUtility.formatCardNumber('12345565'),
                                  accHolderName: '',
                                ),
                              ),

                              SizedBox(
                                width: Dimens.oneHundredEightyOne,
                                child: CustomButton(
                                  margin: EdgeInsets.only(top: Dimens.twenty),
                                  btnText: 'add_account'.tr,
                                  borderRadius: BorderRadius.circular(Dimens.thirty),
                                  contentPadding: EdgeInsets.symmetric(vertical: Dimens.seven, horizontal: Dimens.fortyEight),
                                  btnTextStyle: AppStyles.style13Normal.copyWith(fontWeight: FontWeight.w500, color: themeUtils.blackWhiteSwitchColor),
                                  onTap: () {
                                    UserPaymentComponents.showAddAccountDialog(
                                      context: context,
                                      onAdd: () {},
                                      bankNameController: userPaymentMethodSettingController.bankNameController,
                                      ifscCodeController: userPaymentMethodSettingController.ifscCodeController,
                                      accNumberController: userPaymentMethodSettingController.accNumberController,
                                      accHolderNameController: userPaymentMethodSettingController.accHolderNameController,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ).marginOnly(left: Dimens.thirtyFour),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
