import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/custom_button.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/strings.dart';
import '../../../../utility/utility.dart';
import '../../../common/custom_theme_switch_button.dart';
import '../component/custom_signin_tabbar/bindings/custom_signin_tabbar_binding.dart';
import '../component/custom_signin_tabbar/view/custom_signin_tabbar_screen.dart';
import '../signin_controller.dart';

class UserSignInScreen extends StatelessWidget {
  UserSignInScreen({super.key}) {
    CustomSignInTabBarBinding().dependencies();
  }

  final userSignInScreenController = Get.find<UserSignInController>();

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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(right: Dimens.eighteen),
                  child: signInLayout(context, themeColorsUtil),
                ),
              ),

              /// switch theme button
              const CustomThemeSwitchButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget signInLayout(BuildContext context, ThemeColorsUtil themeColorsUtil) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.only(top: Dimens.seventy, bottom: Dimens.fifty),
      decoration: BoxDecoration(
        color: themeColorsUtil.deepBlackWhiteSwitchColor,
        border: Border.all(color: themeColorsUtil.primaryColorSwitch, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: Dimens.fortyFour, top: Dimens.forty, left: Dimens.fortyFour),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Flexible(
                      child: CommonWidgets.autoSizeRichText(
                        textSpans: [
                          TextSpan(
                            text: 'welcome_to'.tr,
                            style: AppStyles.style21Normal.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                          ),
                          TextSpan(
                            text: " ${'ratings'.tr}",
                            style: AppStyles.style21Bold.copyWith(color: themeColorsUtil.primaryColorSwitch),
                          ),
                        ],
                        minFontSize: 10,
                        maxFontSize: 21,
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          if (userSignInScreenController.selectedRole.value == 1) {
                            RouteManagement.goToUserSignUpView();
                          } else {
                            RouteManagement.goToManagerSignUpView();
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonWidgets.autoSizeText(
                              text: 'no_account'.tr,
                              textStyle: AppStyles.style13Normal.copyWith(color: themeColorsUtil.blackGreySwitchColor),
                              minFontSize: 8,
                              maxFontSize: 13,
                            ),
                            CommonWidgets.autoSizeText(
                              text: 'sign_up'.tr,
                              textStyle: AppStyles.style13Normal.copyWith(color: themeColorsUtil.primaryColorSwitch),
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
                  text: 'sign_in'.tr,
                  textStyle: AppStyles.style55SemiBold.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
                  minFontSize: 30,
                  maxFontSize: 55,
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: Dimens.thirtyFive),
                    child: CustomSignInTabBar(
                      onIndexChange: (index) {
                        userSignInScreenController.selectedRole.value = index;
                      },
                    ),
                  ),
                ),
                textFieldWithLabel(
                    hintText: 'email_address'.tr,
                    labelText: 'enter_your_email_address'.tr,
                    themeColorsUtil: themeColorsUtil,
                    controller: userSignInScreenController.emailOrUserNameController),
                Padding(
                  padding: EdgeInsets.only(top: Dimens.thirtyEight, bottom: Dimens.twelve),
                  child: Obx(
                    () => textFieldWithLabel(
                      hintText: 'password'.tr,
                      labelText: 'enter_your_password'.tr,
                      themeColorsUtil: themeColorsUtil,
                      suffixIcon: InkWell(
                        onTap: () {
                          userSignInScreenController.isShowPassword.value = !userSignInScreenController.isShowPassword.value;
                        },
                        child: userSignInScreenController.isShowPassword.value
                            ? CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityIcon)
                            : CommonWidgets.fromSvg(svgAsset: SvgAssets.eyeVisibilityOffIcon),
                      ),
                      controller: userSignInScreenController.passwordController,
                      obscureText: !userSignInScreenController.isShowPassword.value,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CommonWidgets.autoSizeText(
                    text: 'forgot_password'.tr,
                    textStyle: AppStyles.style13Normal.copyWith(color: themeColorsUtil.primaryColorSwitch),
                    minFontSize: 8,
                    maxFontSize: 13,
                  ),
                ),
                Obx(
                  () => CustomButton(
                    btnText: 'sign_in'.tr,
                    isShowLoading: userSignInScreenController.isShowLoadingOnButton.value,
                    margin: EdgeInsets.only(top: Dimens.fortyFour, bottom: Dimens.seventy),
                    onTap: () async {
                      if (userSignInScreenController.emailOrUserNameController.text.trim().isEmpty) {
                        AppUtility.showSnackBar('please_enter_email'.tr);
                      } else if (userSignInScreenController.passwordController.text.trim().isEmpty) {
                        AppUtility.showSnackBar('please_enter_password'.tr);
                      } else if (userSignInScreenController.passwordController.text.trim().length < 6) {
                        AppUtility.showSnackBar('please_enter_valid_password'.tr);
                      } else {
                        /// sign in user
                        if (userSignInScreenController.selectedRole.value == 1) {
                          String signInStatus = await userSignInScreenController.signInUser(
                            email: userSignInScreenController.emailOrUserNameController.text,
                            password: userSignInScreenController.passwordController.text,
                          );
                          if (signInStatus == CustomStatus.success) {
                            RouteManagement.goToUserHomePageView();
                            userSignInScreenController.clearControllers();
                          } else if (signInStatus == CustomStatus.wrongEmailPassword) {
                            AppUtility.showSnackBar('wrong_email_password'.tr);
                          } else if (signInStatus == CustomStatus.userNotVerified) {
                            RouteManagement.goToUserConformationView(email: userSignInScreenController.emailOrUserNameController.text);
                          } else {
                            AppUtility.showSnackBar('user_not_found'.tr);
                          }
                        } else {
                          String signInStatus = await userSignInScreenController.signInManager(
                            email: userSignInScreenController.emailOrUserNameController.text,
                            password: userSignInScreenController.passwordController.text,
                          );

                          if (signInStatus == CustomStatus.success) {
                            AppUtility.showSnackBar('Sign in Successfully');
                            userSignInScreenController.clearControllers();
                          } else if (signInStatus == CustomStatus.wrongEmailPassword) {
                            AppUtility.showSnackBar('wrong_email_password'.tr);
                          } else {
                            AppUtility.showSnackBar('user_not_found'.tr);
                          }
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
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Dimens.ten),
          child: CommonWidgets.autoSizeText(
            text: labelText,
            textStyle: AppStyles.style16Normal.copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
            minFontSize: 10,
            maxFontSize: 16,
          ),
        ),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
          maxLines: 1,
          fillColor: ColorValues.whiteColor,
        )
      ],
    );
  }
}
