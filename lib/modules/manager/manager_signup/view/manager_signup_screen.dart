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
import '../manager_signup_controller.dart';

class ManagerSignUpScreen extends StatelessWidget {
  ManagerSignUpScreen({super.key});

  final managerSignUpScreenController = Get.find<ManagerSignUpController>();

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeColorsUtil = ThemeColorsUtil(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// signup
              Padding(
                padding: EdgeInsets.only(right: Dimens.eighteen),
                child: signUpLayout(context, themeColorsUtil),
              ),

              /// switch theme button
              const CustomThemeSwitchButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget signUpLayout(BuildContext context, ThemeColorsUtil themeColorsUtil) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.only(bottom: Dimens.forty, top: Dimens.eighty),
      decoration: BoxDecoration(
        color: themeColorsUtil.deepBlackWhiteSwitchColor,
        border: Border.all(color: themeColorsUtil.primaryColorSwitch, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: Dimens.fortyFour,
                top: Dimens.forty,
                left: Dimens.fortyFour),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Flexible(
                      child: CommonWidgets.autoSizeRichText(
                        textSpans: [
                          TextSpan(
                            text: 'welcome_to'.tr,
                            style: AppStyles.style21Normal.copyWith(
                                color: themeColorsUtil.whiteBlackSwitchColor),
                          ),
                          TextSpan(
                            text: " ${'ratings'.tr}",
                            style: AppStyles.style21Bold.copyWith(
                                color: themeColorsUtil.primaryColorSwitch),
                          ),
                        ],
                        minFontSize: 10,
                        maxFontSize: 21,
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          RouteManagement.goToUserSignInScreen();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonWidgets.autoSizeText(
                              text: 'have_an_account'.tr,
                              textStyle: AppStyles.style13Normal.copyWith(
                                  color: themeColorsUtil.blackGreySwitchColor),
                              minFontSize: 8,
                              maxFontSize: 13,
                            ),
                            CommonWidgets.autoSizeText(
                              text: 'sign_in'.tr,
                              textStyle: AppStyles.style13Normal.copyWith(
                                  color: themeColorsUtil.primaryColorSwitch),
                              minFontSize: 8,
                              maxFontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CommonWidgets.autoSizeText(
                  text: 'sign_up'.tr,
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
                          managerSignUpScreenController.emailController),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimens.twentyFive, right: Dimens.nine),
                        child: textFieldWithLabel(
                          hintText: 'full_name'.tr,
                          labelText: 'full_name'.tr,
                          contentPadding: EdgeInsets.only(
                              left: Dimens.thirteen,
                              top: Dimens.nineteen,
                              bottom: Dimens.nineteen),
                          themeColorsUtil: themeColorsUtil,
                          controller:
                              managerSignUpScreenController.userNameController,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimens.twentyThree, left: Dimens.nine),
                        child: textFieldWithLabel(
                          hintText: 'contact_number'.tr,
                          labelText: 'contact_number'.tr,
                          length: 15,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          contentPadding: EdgeInsets.only(
                              left: Dimens.thirteen,
                              top: Dimens.nineteen,
                              bottom: Dimens.nineteen),
                          themeColorsUtil: themeColorsUtil,
                          controller: managerSignUpScreenController
                              .contactNumberController,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.twentyThree),
                  child: textFieldWithLabel(
                    hintText: 'employee_id_manager_id'.tr,
                    labelText: 'employee_id_manager_id'.tr,
                    themeColorsUtil: themeColorsUtil,
                    controller:
                        managerSignUpScreenController.managerIdController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.twentyThree),
                  child: Obx(
                    () => textFieldWithLabel(
                      hintText: 'password'.tr,
                      labelText: 'enter_your_password'.tr,
                      themeColorsUtil: themeColorsUtil,
                      suffixIcon: InkWell(
                        onTap: () {
                          managerSignUpScreenController.isShowPassword.value =
                              !managerSignUpScreenController
                                  .isShowPassword.value;
                        },
                        child:
                            managerSignUpScreenController.isShowPassword.value
                                ? CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.eyeVisibilityIcon)
                                : CommonWidgets.fromSvg(
                                    svgAsset: SvgAssets.eyeVisibilityOffIcon),
                      ),
                      controller:
                          managerSignUpScreenController.passwordController1,
                      obscureText:
                          !managerSignUpScreenController.isShowPassword.value,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.twentyThree),
                  child: Obx(
                    () => textFieldWithLabel(
                      hintText: 'password'.tr,
                      labelText: 'confirm_password'.tr,
                      suffixIcon: InkWell(
                        onTap: () {
                          managerSignUpScreenController
                                  .isShowConfirmPassword.value =
                              !managerSignUpScreenController
                                  .isShowConfirmPassword.value;
                        },
                        child: managerSignUpScreenController
                                .isShowConfirmPassword.value
                            ? CommonWidgets.fromSvg(
                                svgAsset: SvgAssets.eyeVisibilityIcon)
                            : CommonWidgets.fromSvg(
                                svgAsset: SvgAssets.eyeVisibilityOffIcon),
                      ),
                      themeColorsUtil: themeColorsUtil,
                      controller:
                          managerSignUpScreenController.passwordController2,
                      obscureText: !managerSignUpScreenController
                          .isShowConfirmPassword.value,
                    ),
                  ),
                ),
                Obx(
                  () => CustomButton(
                    btnText: 'sign_up'.tr,
                    isShowLoading: managerSignUpScreenController
                        .isShowLoadingOnButton.value,
                    margin: EdgeInsets.only(
                        top: Dimens.thirtyFive, bottom: Dimens.fiftySix),
                    onTap: () async {
                      if (managerSignUpScreenController.emailController.text
                          .trim()
                          .isEmpty) {
                        AppUtility.showSnackBar('please_enter_email'.tr);
                      } else if (managerSignUpScreenController.emailController.text
                              .trim()
                              .isNotEmpty &&
                          !Validators.isValidEmail(managerSignUpScreenController
                              .emailController.text)) {
                        AppUtility.showSnackBar('please_enter_valid_email'.tr);
                      } else if (managerSignUpScreenController.userNameController.text
                          .trim()
                          .isEmpty) {
                        AppUtility.showSnackBar('please_enter_full_name'.tr);
                      } else if (managerSignUpScreenController
                          .contactNumberController.text
                          .trim()
                          .isEmpty) {
                        AppUtility.showSnackBar(
                            'please_enter_contact_number'.tr);
                      } else if (managerSignUpScreenController.contactNumberController.text.trim().length <= 3 ||
                          managerSignUpScreenController.contactNumberController.text
                                  .trim()
                                  .length >
                              15) {
                        AppUtility.showSnackBar(
                            'please_enter_valid_contact_number'.tr);
                      } else if (managerSignUpScreenController
                          .managerIdController.text.isEmpty) {
                        AppUtility.showSnackBar(
                            'please_enter_employee_id_manager_id'.tr);
                      } else if (managerSignUpScreenController.passwordController1.text
                          .trim()
                          .isEmpty) {
                        AppUtility.showSnackBar('please_enter_password'.tr);
                      } else if (managerSignUpScreenController.passwordController1.text
                              .trim()
                              .length <
                          6) {
                        AppUtility.showSnackBar(
                            'password_must_be_at_least_6_characters'.tr);
                      } else if (managerSignUpScreenController.passwordController2.text
                          .trim()
                          .isEmpty) {
                        AppUtility.showSnackBar(
                            'please_enter_confirm_password'.tr);
                      } else if (managerSignUpScreenController.passwordController1.text !=
                          managerSignUpScreenController.passwordController2.text) {
                        AppUtility.showSnackBar(
                            'password_confirm_password_do_not_match'.tr);
                      } else {
                        /// register user
                        bool isManagerExists =
                            await managerSignUpScreenController
                                .checkManagerExists(
                                    email: managerSignUpScreenController
                                        .emailController.text);
                        String registrationStatus =
                            await managerSignUpScreenController.signUpManager(
                          email: managerSignUpScreenController
                              .emailController.text,
                          userName: managerSignUpScreenController
                              .userNameController.text,
                          phoneNumber: managerSignUpScreenController
                              .contactNumberController.text,
                          managerId: managerSignUpScreenController
                              .managerIdController.text,
                          password: managerSignUpScreenController
                              .passwordController1.text,
                        );
                        if (registrationStatus == CustomStatus.success) {
                          AppUtility.showSnackBar('sign up successfully');
                          managerSignUpScreenController.clearControllers();
                        } else if (registrationStatus ==
                            CustomStatus.userExists) {
                          AppUtility.showSnackBar('user_already_exists'.tr);
                        } else {
                          AppUtility.showSnackBar('something_want_wrong'.tr);
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
