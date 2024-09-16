import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_radio_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/utility.dart';

class AddManagerCompoent extends StatelessWidget {
  const AddManagerCompoent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        /*body: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.thirty),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Dimens.twentyEight, bottom: Dimens.ten, left: Dimens.twentyEight),
              child: CommonWidgets.autoSizeText(
                text: 'my_account'.tr,
                textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                minFontSize: 16,
                maxFontSize: 24,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.twentyEight, right: Dimens.fifty, bottom: Dimens.twentyEight),
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// profile picture
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimens.eightyFive,
                              width: Dimens.eightyFive,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  ClipOval(
                                    child: Obx(
                                      () => NxNetworkImage(
                                        imageUrl: userMyAccountSettingController.userData.value?.profileImage?.isNotEmpty ?? false
                                            ? userMyAccountSettingController.userData.value?.profileImage ?? StringValues.noProfileImageUrl
                                            : StringValues.noProfileImageUrl,
                                        height: Dimens.eightyFive,
                                        width: Dimens.eightyFive,
                                        imageFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  /// Edit profile picture
                                  InkWell(
                                    onTap: () {
                                      UserEditProfileDialogComponent.userEditProfileDialog(
                                        context: context,
                                        themeUtils: themeUtils,
                                        onClose: () {
                                          RouteManagement.goToBack();
                                        },
                                        onChange: () async {
                                          String? updateImageStatus = await userMyAccountSettingController.pickAndUpdateImage();
                                          if (updateImageStatus == CustomStatus.success) {
                                            RouteManagement.goToBack();
                                            AppUtility.showSnackBar('profile_picture_updated_successfully'.tr);
                                          } else {
                                            AppUtility.showSnackBar('something_want_wrong'.tr);
                                          }
                                        },
                                        onRemove: () async {
                                          String? removeStatus = await userMyAccountSettingController.removeProfilePicture();
                                          if (removeStatus == CustomStatus.success) {
                                            RouteManagement.goToBack();
                                            AppUtility.showSnackBar('profile_picture_removed_successfully'.tr);
                                          } else {
                                            AppUtility.showSnackBar('something_want_wrong'.tr);
                                          }
                                        },
                                        imageUrl: userMyAccountSettingController.userData.value?.profileImage ?? StringValues.noProfileImageUrl,
                                      );
                                    },
                                    child: Container(
                                      height: Dimens.twentyEight,
                                      width: Dimens.twentyEight,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: themeUtils.primaryColorSwitch,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorValues.blackColor.withOpacity(0.25),
                                            offset: const Offset(0.25, 0.25),
                                            blurRadius: 6,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: Dimens.eighteen,
                                        color: themeUtils.blackWhiteSwitchColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ).marginOnly(right: Dimens.twentyTwo),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonWidgets.autoSizeText(
                                  text: userMyAccountSettingController.userData.value?.username ?? '',
                                  textStyle: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                  minFontSize: 10,
                                  maxFontSize: 18,
                                ),
                                CommonWidgets.autoSizeText(
                                  text: userMyAccountSettingController.userData.value?.email ?? '',
                                  textStyle: AppStyles.style13Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                  minFontSize: 8,
                                  maxFontSize: 13,
                                ),
                              ],
                            ),
                          ],
                        ).marginOnly(top: Dimens.thirty, left: Dimens.eighteen),

                        /// full name & email
                        Row(
                          children: [
                            Flexible(
                              child: textFieldWithLabel(
                                label: 'full_name'.tr,
                                textField: CustomTextField(
                                  controller: userMyAccountSettingController.fullNameController,
                                  borderRadius: BorderRadius.circular(Dimens.six),
                                  hintText: 'full_name'.tr,
                                  hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                  fillColor: ColorValues.transparent,
                                  borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                ),
                              ).marginOnly(right: Dimens.eight),
                            ),
                            Flexible(
                              child: textFieldWithLabel(
                                label: 'email'.tr,
                                textField: CustomTextField(
                                  controller: userMyAccountSettingController.emailController,
                                  isReadOnly: true,
                                  borderRadius: BorderRadius.circular(Dimens.six),
                                  hintText: 'email'.tr,
                                  hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                  fillColor: ColorValues.transparent,
                                  borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                ),
                              ).marginOnly(left: Dimens.eight),
                            ),
                          ],
                        ).marginOnly(top: Dimens.thirtyFive, left: Dimens.eighteen),

                        /// phone number & city, state
                        Row(
                          children: [
                            Flexible(
                              child: textFieldWithLabel(
                                label: 'phone_number'.tr,
                                textField: CustomTextField(
                                  controller: userMyAccountSettingController.phoneNumberController,
                                  borderRadius: BorderRadius.circular(Dimens.six),
                                  hintText: 'phone_number'.tr,
                                  hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  length: 15,
                                  contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                  fillColor: ColorValues.transparent,
                                  borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                ),
                              ).marginOnly(right: Dimens.eight),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: textFieldWithLabel(
                                      label: 'city'.tr,
                                      textField: CustomTextField(
                                        controller: userMyAccountSettingController.cityController,
                                        borderRadius: BorderRadius.circular(Dimens.six),
                                        textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                        hintText: 'city'.tr,
                                        hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                        contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                        fillColor: ColorValues.transparent,
                                        borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                      ),
                                    ).marginOnly(right: Dimens.seven),
                                  ),
                                  Flexible(
                                    child: textFieldWithLabel(
                                      label: 'state'.tr,
                                      textField: CustomTextField(
                                        controller: userMyAccountSettingController.stateController,
                                        borderRadius: BorderRadius.circular(Dimens.six),
                                        textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                        hintText: 'state'.tr,
                                        hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                        contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                        fillColor: ColorValues.transparent,
                                        borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                      ),
                                    ).marginOnly(left: Dimens.seven),
                                  ),
                                ],
                              ).marginOnly(left: Dimens.eight),
                            ),
                          ],
                        ).marginOnly(top: Dimens.sixTeen, left: Dimens.eighteen),

                        /// pan number & gender
                        Row(
                          children: [
                            Flexible(
                              child: textFieldWithLabel(
                                label: 'pan_number'.tr,
                                textField: CustomTextField(
                                  controller: userMyAccountSettingController.panNumberController,
                                  hintText: 'pan_number'.tr,
                                  hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  borderRadius: BorderRadius.circular(Dimens.six),
                                  textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                  fillColor: ColorValues.transparent,
                                  borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                ),
                              ).marginOnly(right: Dimens.eight),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CommonWidgets.autoSizeText(
                                    text: 'gender'.tr,
                                    textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                    minFontSize: 8,
                                    maxFontSize: 14,
                                  ).marginOnly(bottom: Dimens.twelve),
                                  Obx(
                                    () => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            userMyAccountSettingController.userGender.value = 'male';
                                          },
                                          child: CustomRadioButton(
                                            isSelected: userMyAccountSettingController.userGender.value == 'male',
                                            labelText: 'male'.tr,
                                            labelPadding: EdgeInsets.only(left: Dimens.five),
                                            labelTextStyle: AppStyles.style12Normal
                                                .copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            userMyAccountSettingController.userGender.value = 'female';
                                          },
                                          child: CustomRadioButton(
                                            isSelected: userMyAccountSettingController.userGender.value == 'female',
                                            labelText: 'female'.tr,
                                            labelPadding: EdgeInsets.only(left: Dimens.five),
                                            labelTextStyle: AppStyles.style12Normal
                                                .copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w500),
                                          ),
                                        ).marginOnly(left: Dimens.twelve),
                                      ],
                                    ),
                                  ),
                                ],
                              ).marginOnly(left: Dimens.eight),
                            ),
                          ],
                        ).marginOnly(top: Dimens.twenty, left: Dimens.eighteen),

                        /// password
                        Row(
                          children: [
                            Obx(
                              () => Flexible(
                                child: textFieldWithLabel(
                                  label: 'password'.tr,
                                  textField: CustomTextField(
                                    controller: userMyAccountSettingController.passwordController,
                                    hintText: 'password'.tr,
                                    hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                    isReadOnly: true,
                                    borderRadius: BorderRadius.circular(Dimens.six),
                                    textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                                    contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                                    fillColor: ColorValues.transparent,
                                    borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        userMyAccountSettingController.isShowPassword.value = !userMyAccountSettingController.isShowPassword.value;
                                      },
                                      child: userMyAccountSettingController.isShowPassword.value
                                          ? CommonWidgets.fromSvg(
                                              svgAsset: SvgAssets.eyeVisibilityIcon,
                                              width: Dimens.eighteen,
                                              height: Dimens.fifteen,
                                              boxFit: BoxFit.fill,
                                            )
                                          : CommonWidgets.fromSvg(
                                              svgAsset: SvgAssets.eyeVisibilityOffIcon,
                                              width: Dimens.twenty,
                                              height: Dimens.sevenTeen,
                                              boxFit: BoxFit.fill,
                                            ),
                                    ),
                                    maxLines: 1,
                                    obscureText: !userMyAccountSettingController.isShowPassword.value,
                                  ),
                                ).marginOnly(right: Dimens.eight),
                              ),
                            ),
                            const Flexible(child: SizedBox.shrink()),
                          ],
                        ).marginOnly(top: Dimens.nine, left: Dimens.eighteen),

                        /// Edit button
                        Row(
                          children: [
                            Flexible(
                              child: CustomButton(
                                btnText: 'edit'.tr,
                                contentPadding: EdgeInsets.symmetric(vertical: Dimens.sixTeen),
                                borderRadius: BorderRadius.circular(Dimens.thirty),
                                margin: EdgeInsets.only(top: Dimens.fifteen, left: Dimens.fifteen),
                                onTap: () async {
                                  String? updateStatus = await userMyAccountSettingController.updateUserData();
                                  if (updateStatus == CustomStatus.success) {
                                    AppUtility.showSnackBar('your_profile_updated_successfully'.tr);
                                  } else {
                                    AppUtility.showSnackBar('failed_to_update_profile'.tr);
                                  }
                                },
                              ),
                            ),
                            const Flexible(child: SizedBox.shrink()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
        );
  }
}
