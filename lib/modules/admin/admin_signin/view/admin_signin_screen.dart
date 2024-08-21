import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/helper/validators.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/custom_button.dart';
import '../../../../common/custom_theme_switch_button.dart';
import '../../../../constant/dimens.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/utility.dart';
import '../admin_signin_controller.dart';

class AdmSignInScreen extends StatelessWidget {
  AdmSignInScreen({super.key});

  final adminsignInScreenController = Get.find<AdminSignInController>();

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeColorsUtil = ThemeColorsUtil(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                color: themeColorsUtil.interiorUpColor,
              ),
              Expanded(
                child: Container(
                  color: themeColorsUtil.darkGrayWhiteSwitchColor,
                ),
              ),
            ],
          ),
          Center(child: signUpLayout(context, themeColorsUtil)),
          const Positioned(
              right: 0, bottom: 0, child: CustomThemeSwitchButton())
        ],
      ),
    );
  }

  Widget signUpLayout(BuildContext context, ThemeColorsUtil themeColorsUtil) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        decoration: BoxDecoration(
          color: themeColorsUtil.deepBlackWhiteSwitchColor,
          border:
              Border.all(color: themeColorsUtil.primaryColorSwitch, width: 1),
          borderRadius: BorderRadius.circular(40),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(
                Dimens.fortyFour,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidgets.autoSizeRichText(
                    textSpans: [
                      TextSpan(
                        text: 'welcome_to'.tr,
                        style: AppStyles.style21Normal.copyWith(
                            color: themeColorsUtil.whiteBlackSwitchColor),
                      ),
                      TextSpan(
                        text: " ${'admin'.tr}",
                        style: AppStyles.style21Bold.copyWith(
                            color: themeColorsUtil.primaryColorSwitch),
                      ),
                    ],
                    minFontSize: 10,
                    maxFontSize: 21,
                  ),
                  CommonWidgets.autoSizeText(
                    text: 'sign_in'.tr,
                    textStyle: AppStyles.style55SemiBold
                        .copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                    minFontSize: 30,
                    maxFontSize: 55,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.forty),
                    child: textFieldWithLabel(
                        hintText: 'email_address'.tr,
                        labelText: 'enter_your_email_address'.tr,
                        themeColorsUtil: themeColorsUtil,
                        controller:
                            adminsignInScreenController.emailController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.thirtyEight),
                    child: Obx(
                      () => textFieldWithLabel(
                        hintText: 'password'.tr,
                        labelText: 'enter_your_password'.tr,
                        themeColorsUtil: themeColorsUtil,
                        suffixIcon: InkWell(
                          onTap: () {
                            adminsignInScreenController.isShowPassword.value =
                                !adminsignInScreenController
                                    .isShowPassword.value;
                          },
                          child:
                              adminsignInScreenController.isShowPassword.value
                                  ? CommonWidgets.fromSvg(
                                      svgAsset: SvgAssets.eyeVisibilityIcon)
                                  : CommonWidgets.fromSvg(
                                      svgAsset: SvgAssets.eyeVisibilityOffIcon),
                        ),
                        controller:
                            adminsignInScreenController.passwordController,
                        obscureText:
                            !adminsignInScreenController.isShowPassword.value,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.twelve),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CommonWidgets.autoSizeText(
                        text: 'forgot_password'.tr,
                        textStyle: AppStyles.style13Normal.copyWith(
                            color: themeColorsUtil.primaryColorSwitch),
                        minFontSize: 8,
                        maxFontSize: 13,
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomButton(
                      btnText: 'sign_in'.tr,
                      isShowLoading: adminsignInScreenController
                          .isShowLoadingOnButton.value,
                      margin: EdgeInsets.only(top: Dimens.fortyFour),
                      onTap: () async {
                        if (adminsignInScreenController.emailController.text
                            .trim()
                            .isEmpty) {
                          AppUtility.showSnackBar('please_enter_email'.tr);
                        } else if (adminsignInScreenController
                                .emailController.text
                                .trim()
                                .isNotEmpty &&
                            !Validators.isValidEmail(adminsignInScreenController
                                .emailController.text)) {
                          AppUtility.showSnackBar(
                              'please_enter_valid_email'.tr);
                        } else if (adminsignInScreenController
                            .passwordController.text
                            .trim()
                            .isEmpty) {
                          AppUtility.showSnackBar('please_enter_password'.tr);
                        } else if (adminsignInScreenController
                                .passwordController.text
                                .trim()
                                .length <
                            6) {
                          AppUtility.showSnackBar(
                              'password_must_be_at_least_6_characters'.tr);
                        } else {
                          String signInStatus =
                              await adminsignInScreenController.signInAdmin(
                            email: adminsignInScreenController
                                .emailController.text,
                            password: adminsignInScreenController
                                .passwordController.text,
                          );

                          if (signInStatus == CustomStatus.success) {
                            RouteManagement.goToUserHomePageView();
                            adminsignInScreenController.clearControllers();
                          } else if (signInStatus ==
                              CustomStatus.wrongEmailPassword) {
                            AppUtility.showSnackBar('wrong_email_password'.tr);
                          } else {
                            AppUtility.showSnackBar('user_not_found'.tr);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWithLabel(
      {required ThemeColorsUtil themeColorsUtil,
      required String labelText,
      required String hintText,
      Widget? suffixIcon,
      bool? obscureText,
      int? length,
      List<TextInputFormatter>? inputFormatters,
      required TextEditingController controller,
      EdgeInsetsGeometry? contentPadding}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Dimens.ten),
          child: CommonWidgets.autoSizeText(
            text: labelText,
            textStyle: AppStyles.style16Normal
                .copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
            minFontSize: 10,
            maxFontSize: 16,
          ),
        ),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          suffixIcon: suffixIcon,
          length: length,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          maxLines: 1,
          contentPadding: contentPadding,
          fillColor: ColorValues.whiteColor,
        )
      ],
    );
  }
}
