import 'package:RatingRadar_app/modules/admin/admin_manager/admin_manager_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../../../utility/utility.dart';
import '../../../user/user_my_account_setting/components/user_edit_profile_dialog_component.dart';

class AddManagerCompoent extends StatelessWidget {
  AddManagerCompoent({super.key});

  final adminManagerController = Get.find<AdminManagerController>();

  late ThemeColorsUtil themeUtils;
  @override
  Widget build(BuildContext context) {
    themeUtils = ThemeColorsUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: themeUtils.blackWhiteSwitchColor,
        border: Border.all(color: themeUtils.primaryColorSwitch),
        borderRadius: BorderRadius.circular(
          Dimens.thirty,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: Dimens.twentyEight, bottom: Dimens.ten, left: Dimens.twentyEight, right: Dimens.twenty),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidgets.autoSizeText(
                  text: 'manager_account'.tr,
                  textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                  minFontSize: 16,
                  maxFontSize: 24,
                ),
                IconButton(
                  onPressed: () {
                    RouteManagement.goToBack();
                  },
                  icon: Icon(
                    Icons.close,
                    color: themeUtils.whiteBlackSwitchColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: Dimens.twentyEight, right: Dimens.fifty, bottom: Dimens.twentyEight),
                child: Column(
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
                                    // imageUrl: '',
                                    imageUrl: adminManagerController.managerData.value?.profileImg?.isNotEmpty ?? false
                                        ? adminManagerController.managerData.value?.profileImg ?? StringValues.noProfileImageUrl
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
                                      String? updateImageStatus = ''; //await adminManagerController.pickAndUpdateImage();
                                      if (updateImageStatus == CustomStatus.success) {
                                        RouteManagement.goToBack();
                                        AppUtility.showSnackBar('profile_picture_updated_successfully'.tr);
                                      } else {
                                        AppUtility.showSnackBar('something_want_wrong'.tr);
                                      }
                                    },
                                    onRemove: () async {
                                      String? removeStatus = ''; //await adminManagerController.removeProfilePicture();
                                      if (removeStatus == CustomStatus.success) {
                                        RouteManagement.goToBack();
                                        AppUtility.showSnackBar('profile_picture_removed_successfully'.tr);
                                      } else {
                                        AppUtility.showSnackBar('something_want_wrong'.tr);
                                      }
                                    },
                                    imageUrl: adminManagerController.managerData.value?.profileImg ?? StringValues.noProfileImageUrl, //imageUrl: '',
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
                              text: adminManagerController.managerData.value?.username ?? '',
                              textStyle: AppStyles.style18SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 10,
                              maxFontSize: 18,
                            ),
                            CommonWidgets.autoSizeText(
                              text: adminManagerController.managerData.value?.email ?? '',
                              textStyle: AppStyles.style13Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 8,
                              maxFontSize: 13,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              adminManagerController.managerData.value?.username ?? '',
                              style: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            ),
                            Text(
                              adminManagerController.managerData.value?.email ?? '',
                              style: AppStyles.style12Normal.copyWith(color: themeUtils.whiteBlackSwitchColor),
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
                            label: 'manager_name'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.managerNameController,
                              borderRadius: BorderRadius.circular(Dimens.six),
                              hintText: 'manager_name'.tr,
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
                            label: 'company_name'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.companyEmailController,
                              isReadOnly: true,
                              borderRadius: BorderRadius.circular(Dimens.six),
                              hintText: 'company_name'.tr,
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
                              controller: adminManagerController.phoneNumberController,
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
                                    controller: adminManagerController.cityController, //userMyAccountSettingController.cityController,
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
                                    controller: adminManagerController.stateController, //userMyAccountSettingController.stateController,
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

                    /// pan number & gst number
                    Row(
                      children: [
                        Flexible(
                          child: textFieldWithLabel(
                            label: 'pan_number'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.panNumberController, //userMyAccountSettingController.panNumberController,
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
                          child: textFieldWithLabel(
                            label: 'company_gstin_number'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.panNumberController, //userMyAccountSettingController.panNumberController,
                              hintText: 'company_gstin_number'.tr,
                              hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                              borderRadius: BorderRadius.circular(Dimens.six),
                              textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                              contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                              fillColor: ColorValues.transparent,
                              borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                            ),
                          ).marginOnly(right: Dimens.eight),
                        ),
                      ],
                    ).marginOnly(top: Dimens.twenty, left: Dimens.eighteen),

                    /// password & aadhar
                    Row(
                      children: [
                        Flexible(
                          child: textFieldWithLabel(
                            label: 'aadhar_card_number'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.panNumberController, //userMyAccountSettingController.panNumberController,
                              hintText: 'aadhar_card_number'.tr,
                              hintStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                              borderRadius: BorderRadius.circular(Dimens.six),
                              textStyle: AppStyles.style12SemiLight.copyWith(color: ColorValues.lightGrayColor),
                              contentPadding: EdgeInsets.symmetric(horizontal: Dimens.eighteen, vertical: Dimens.sixTeen),
                              fillColor: ColorValues.transparent,
                              borderSide: BorderSide(color: themeUtils.primaryColorSwitch, width: 1),
                            ),
                          ).marginOnly(right: Dimens.eight),
                        ),
                        Obx(
                          () => Flexible(
                            child: textFieldWithLabel(
                              label: 'password'.tr,
                              textField: CustomTextField(
                                controller: adminManagerController.passwordController, //adminManagerController.passwordController,
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
                                    adminManagerController.isShowPassword.value = !adminManagerController.isShowPassword.value;
                                  },
                                  child: adminManagerController.isShowPassword.value
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
                                obscureText: !adminManagerController.isShowPassword.value,
                              ),
                            ).marginOnly(right: Dimens.eight),
                          ),
                        ),
                      ],
                    ).marginOnly(top: Dimens.nine, left: Dimens.eighteen),

                    /// manager id  & add doc images
                    Row(
                      children: [
                        Flexible(
                          child: textFieldWithLabel(
                            label: 'manager_emp_id'.tr,
                            textField: CustomTextField(
                              controller: adminManagerController.panNumberController, //userMyAccountSettingController.panNumberController,
                              hintText: 'manager_emp_id'.tr,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DottedBorder(
                                color: ColorValues.primaryColorYellow,
                                radius: Radius.circular(Dimens.twelve),
                                borderType: BorderType.RRect,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimens.twenty, vertical: Dimens.fifteen),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimens.twelve),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: themeUtils.primaryColorSwitch,
                                      ),
                                      Text(
                                        "aadhar".tr,
                                        style: AppStyles.style12Normal.copyWith(color: themeUtils.primaryColorSwitch),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DottedBorder(
                                color: ColorValues.primaryColorYellow,
                                radius: Radius.circular(Dimens.twelve),
                                borderType: BorderType.RRect,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimens.twenty, vertical: Dimens.fifteen),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimens.twelve),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: themeUtils.primaryColorSwitch,
                                      ),
                                      Text(
                                        "pan_card".tr,
                                        style: AppStyles.style12Normal.copyWith(color: themeUtils.primaryColorSwitch),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DottedBorder(
                                color: ColorValues.primaryColorYellow,
                                radius: Radius.circular(Dimens.twelve),
                                borderType: BorderType.RRect,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimens.twenty, vertical: Dimens.fifteen),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimens.twelve),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: themeUtils.primaryColorSwitch,
                                      ),
                                      Text(
                                        "gst_in".tr,
                                        style: AppStyles.style12Normal.copyWith(color: themeUtils.primaryColorSwitch),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).marginOnly(top: Dimens.nine, left: Dimens.eighteen),

                    /// Edit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                            btnText: adminManagerController.isCancle.value ? 'cancel'.tr : 'edit'.tr,
                            contentPadding: EdgeInsets.symmetric(vertical: Dimens.eleven, horizontal: Dimens.sixtyFive),
                            borderRadius: BorderRadius.circular(Dimens.thirty),
                            margin: EdgeInsets.only(top: Dimens.fifteen, left: Dimens.fifteen),
                            onTap: () async {
                              if (adminManagerController.isCancle.value) {
                                RouteManagement.goToBack();
                              } else {
                                String? updateStatus = ''; //await adminManagerController.updateUserData();
                                if (updateStatus == CustomStatus.success) {
                                  AppUtility.showSnackBar('your_profile_updated_successfully'.tr);
                                } else {
                                  AppUtility.showSnackBar('failed_to_update_profile'.tr);
                                }
                              }
                            }),
                        CustomButton(
                          btnText: 'save'.tr,
                          contentPadding: EdgeInsets.symmetric(vertical: Dimens.eleven, horizontal: Dimens.sixtyFive),
                          borderRadius: BorderRadius.circular(Dimens.thirty),
                          margin: EdgeInsets.only(top: Dimens.fifteen, left: Dimens.fifteen),
                          onTap: () async {
                            String? updateStatus = ''; //await adminManagerController.updateUserData();
                            if (updateStatus == CustomStatus.success) {
                              AppUtility.showSnackBar('your_profile_updated_successfully'.tr);
                            } else {
                              AppUtility.showSnackBar('failed_to_update_profile'.tr);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldWithLabel({required String label, required Widget textField}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonWidgets.autoSizeText(
          text: label,
          textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.whiteBlackSwitchColor),
          minFontSize: 8,
          maxFontSize: 14,
        ).marginOnly(bottom: Dimens.nine),
        textField
      ],
    );
  }
}
