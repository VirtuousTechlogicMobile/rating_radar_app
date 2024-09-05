import 'dart:developer';

import 'package:RatingRadar_app/modules/admin/admin_submit_ad/model/admin_submit_ad_data_model.dart';
import 'package:RatingRadar_app/modules/admin/drawer/view/admin_drawer_view.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../common/file_image.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/utility.dart';
import '../../admin_header/bindings/admin_header_binding.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../admin_submit_ad_controller.dart';

class AdminSubmitAdScreen extends StatelessWidget {
  final String adDocumentId;
  final adminSubmitAdController = Get.find<AdminSubmitAdController>();

  AdminSubmitAdScreen({super.key, required this.adDocumentId}) {
    // adminSubmitAdController.getAdsDetailData(docId: adDocumentId);
    adminSubmitAdController.getTotalSubmittedAdsCount(adId: adDocumentId);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Scaffold(
      backgroundColor: themeUtils.screensBgSwitchColor,
      body: Row(
        children: [
          AdminDrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                screenMainLayout(
                  themeUtils: themeUtils,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    AdminHeaderBinding().dependencies();
    return AdminHeaderView(
      isDashboardScreen: false,
      isAdsListScreen: false,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            margin: EdgeInsets.only(
                left: Dimens.thirtyEight,
                right: Dimens.thirtyEight,
                bottom: Dimens.fortyFive,
                top: Dimens.thirtyEight),
            decoration: BoxDecoration(
              color: themeUtils.drawerBgWhiteSwitchColor,
              borderRadius: BorderRadius.circular(Dimens.thirty),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  spreadRadius: 0,
                  blurRadius: 50,
                  color:
                      themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.thirty),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimens.thirtyEight,
                    right: Dimens.thirtyEight,
                    bottom: Dimens.fortyFive,
                    top: Dimens.twentyEight),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: Dimens.seven),
                                  child: CommonWidgets.autoSizeText(
                                    text: 'add_ads'.tr,
                                    textStyle: AppStyles.style24Bold.copyWith(
                                        color:
                                            themeUtils.whiteBlackSwitchColor),
                                    minFontSize: 16,
                                    maxFontSize: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: Dimens.ten),
                                  child: CommonWidgets.autoSizeText(
                                    text: 'add_company_ads'.tr,
                                    textStyle: AppStyles.style14Normal.copyWith(
                                        color: themeUtils.primaryColorSwitch),
                                    minFontSize: 16,
                                    maxFontSize: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: Dimens.thirty),
                                  child: textFieldWithLabel(
                                      controller: adminSubmitAdController
                                          .adNameController,
                                      hintText: 'ad_name'.tr,
                                      labelText: 'enter_ad_name'.tr,
                                      themeColorsUtil: themeUtils,
                                      obscureText: false,
                                      maxLines: 1),
                                ),
                                textFieldWithLabel(
                                  controller: adminSubmitAdController
                                      .byCompanyNameController,
                                  hintText: 'company_name'.tr,
                                  labelText: 'enter_name_of_company'.tr,
                                  themeColorsUtil: themeUtils,
                                  obscureText: false,
                                  maxLines: 1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: Dimens.twelve, top: Dimens.nine),
                                  child: CommonWidgets.autoSizeText(
                                    text: 'upload_image'.tr,
                                    textStyle: AppStyles.style16Normal.copyWith(
                                        color:
                                            themeUtils.whiteBlackSwitchColor),
                                    minFontSize: 10,
                                    maxFontSize: 16,
                                  ),
                                ),
                                // Add Image Section
                                Obx(
                                  () => Visibility(
                                    visible: adminSubmitAdController
                                            .preFilledAdDetailData.value ==
                                        null,
                                    replacement: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: Dimens.ten,
                                      children: List.generate(
                                        adminSubmitAdController
                                                .preFilledAdDetailData
                                                .value
                                                ?.imageList
                                                ?.length ??
                                            0,
                                        (index) {
                                          return NxNetworkImage(
                                            imageUrl: adminSubmitAdController
                                                    .preFilledAdDetailData
                                                    .value
                                                    ?.imageList?[index] ??
                                                '',
                                            width: Dimens.hundred,
                                            height: Dimens.hundred,
                                            imageFit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: Dimens.ten,
                                      children: List.generate(
                                        4, // Maximum of 4 image slots
                                        (index) {
                                          return index <
                                                  adminSubmitAdController
                                                      .pickedFiles.length
                                              ? Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    NxFileImage(
                                                      file:
                                                          adminSubmitAdController
                                                                  .pickedFiles[
                                                              index],
                                                      width: Dimens.hundred,
                                                      height: Dimens.hundred,
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: InkWell(
                                                        onTap: () {
                                                          adminSubmitAdController
                                                              .removeImage(
                                                                  index);
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          size: Dimens.twenty,
                                                          color: themeUtils
                                                              .primaryColorSwitch,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  dashPattern: const [10, 10],
                                                  color: themeUtils
                                                      .primaryColorSwitch,
                                                  strokeWidth: 1,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await adminSubmitAdController
                                                          .pickImages();
                                                    },
                                                    child: Stack(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      children: [
                                                        Container(
                                                          width: Dimens.hundred,
                                                          height:
                                                              Dimens.hundred,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: themeUtils
                                                                .primaryColorSwitch
                                                                .withOpacity(
                                                                    0.10),
                                                          ),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              CommonWidgets
                                                                  .fromSvg(
                                                                svgAsset: SvgAssets
                                                                    .uploadImageIcon,
                                                                color: themeUtils
                                                                    .primaryColorSwitch,
                                                              ),
                                                              CommonWidgets
                                                                  .fromSvg(
                                                                svgAsset: SvgAssets
                                                                    .uploadImageAddIcon,
                                                                color: themeUtils
                                                                    .primaryColorSwitch,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: Dimens
                                                                      .ten),
                                                          child: CommonWidgets
                                                              .autoSizeText(
                                                            text: 'upload_image'
                                                                .tr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            textStyle: AppStyles
                                                                .style16Normal
                                                                .copyWith(
                                                              color: themeUtils
                                                                  .primaryColorSwitch,
                                                            ),
                                                            minFontSize: 10,
                                                            maxFontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: Dimens.thirty),
                                  child: textFieldWithLabel(
                                    controller: adminSubmitAdController
                                        .adContentController,
                                    hintText: 'enter_description'.tr,
                                    labelText: 'enter_description'.tr,
                                    themeColorsUtil: themeUtils,
                                    obscureText: false,
                                    maxLines: 5,
                                  ),
                                ),
                                textFieldWithLabel(
                                  controller: adminSubmitAdController
                                      .adManagerIdController,
                                  hintText: 'enter_manager_id'.tr,
                                  labelText: 'enter_manager_id'.tr,
                                  themeColorsUtil: themeUtils,
                                  obscureText: false,
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: textFieldWithLabel(
                                          controller: adminSubmitAdController
                                              .adLocationController,
                                          hintText: 'location'.tr,
                                          labelText: 'location'.tr,
                                          themeColorsUtil: themeUtils,
                                          obscureText: false,
                                          maxLines: 1),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimens.twentyEight),
                                        child: textFieldWithLabel(
                                            controller: adminSubmitAdController
                                                .adPriceController,
                                            hintText: 'amount'.tr,
                                            labelText: 'enter_price_amount'.tr,
                                            themeColorsUtil: themeUtils,
                                            obscureText: false,
                                            maxLines: 1),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Preview Image Area
                          Obx(
                            () => // Inside your Widget build method or wherever you need to display the image
                                Padding(
                              padding: EdgeInsets.only(left: Dimens.sixty),
                              child: Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    if (adminSubmitAdController
                                        .pickedFiles.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Dimens.thirtyTwo,
                                            bottom: Dimens.twenty),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                // For web, use Image.network
                                                Image.network(
                                                  adminSubmitAdController
                                                      .pickedFiles[
                                                          adminSubmitAdController
                                                              .currentImageIndex
                                                              .value]
                                                      .path,
                                                  fit: BoxFit.fill,
                                                  width: constraints.maxWidth /
                                                      2.5,
                                                  height: constraints.maxWidth /
                                                      4.5,
                                                ),

                                                Positioned(
                                                  right: 10,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      size: Dimens.twentyTwo,
                                                      color: themeUtils
                                                          .primaryColorSwitch,
                                                    ),
                                                    onPressed: () {
                                                      adminSubmitAdController
                                                          .nextImage();
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 10,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      size: Dimens.twentyTwo,
                                                      color: themeUtils
                                                          .primaryColorSwitch,
                                                    ),
                                                    onPressed: () {
                                                      adminSubmitAdController
                                                          .previousImage();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      Container(
                                        color: Colors.grey, // Placeholder color
                                        width: constraints.maxWidth / 2.5,
                                        height: constraints.maxWidth / 4.5,
                                        child: const Center(
                                          child: Text(
                                            'No Image Selected',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (adminSubmitAdController.preFilledAdDetailData.value ==
                          null)
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.sixty, bottom: Dimens.twenty),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// cancel button
                              InkWell(
                                onTap: () {
                                  RouteManagement.goToBack();
                                },
                                child: SizedBox(
                                  width: Dimens.hundred,
                                  child: CustomButton(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.thirty),
                                    margin:
                                        EdgeInsets.only(right: Dimens.seven),
                                    btnText: 'cancel'.tr,
                                  ),
                                ),
                              ),

                              /// Submit Button
                              InkWell(
                                onTap: () async {
                                  // Check if the number of picked images is less than required
                                  if (adminSubmitAdController
                                          .pickedFiles.length <
                                      4) {
                                    AppUtility.showSnackBar(
                                        'please_upload_all_images'.tr);
                                  } else {
                                    try {
                                      // Get the user ID
                                      String userId =
                                          await adminSubmitAdController
                                              .getUid();

                                      // Create the AdminSubmitAdDataModel with required details
                                      AdminSubmitAdDataModel adDataModel =
                                          AdminSubmitAdDataModel(
                                        adId: adminSubmitAdController
                                                .adsDetailData.value?.docId ??
                                            '',
                                        uId: userId,
                                        addedDate: DateTime.now(),
                                        comments: adminSubmitAdController
                                            .adContentController.text,
                                        status: CustomStatus.pending,
                                        adName: adminSubmitAdController
                                                .adsDetailData.value?.adName ??
                                            '',
                                        company: adminSubmitAdController
                                                .adsDetailData
                                                .value
                                                ?.byCompany ??
                                            '',
                                        adPrice: adminSubmitAdController
                                                .adsDetailData.value?.adPrice ??
                                            0,
                                      );

                                      // Store the ad data and get the document ID
                                      String? documentId =
                                          await adminSubmitAdController
                                              .storeUserSubmittedAds(
                                        adminSubmitAdDataModel: adDataModel,
                                      );

                                      // Check if the document ID is not null (successful submission)
                                      if (documentId != null) {
                                        RouteManagement.goToBack();
                                        AppUtility.showSnackBar(
                                            'task_submitted_successfully'.tr);
                                      } else {
                                        AppUtility.showSnackBar(
                                            'something_went_wrong'.tr);
                                      }
                                    } catch (e) {
                                      // Handle unexpected errors
                                      AppUtility.showSnackBar(
                                          'something_went_wrong'.tr);
                                      log("Exception: $e"); // Log the exception for debugging
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: Dimens.hundred,
                                  child: CustomButton(
                                    isShowShadow: false,
                                    borderRadius:
                                        BorderRadius.circular(Dimens.thirty),
                                    btnText: 'submit'.tr,
                                  ),
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
          );
        },
      ),
    );
  }

  Widget textFieldWithLabel(
      {required ThemeColorsUtil themeColorsUtil,
      required String labelText,
      required String hintText,
      required int maxLines,
      Widget? suffixIcon,
      bool? obscureText,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Dimens.twelve),
          child: CommonWidgets.autoSizeText(
            text: labelText,
            textStyle: AppStyles.style16Normal
                .copyWith(color: themeColorsUtil.whiteBlackSwitchColor),
            minFontSize: 10,
            maxFontSize: 16,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: Dimens.sixTeen),
          child: CustomTextField(
            controller: controller,
            hintText: hintText,
            suffixIcon: suffixIcon,
            obscureText: obscureText,
            maxLines: maxLines,
            borderSide:
                BorderSide(color: themeColorsUtil.adsTextFieldBorderColor),
            fillColor: ColorValues.transparent,
            hintStyle: const TextStyle(color: ColorValues.lightGrayColor),
          ),
        )
      ],
    );
  }
}
