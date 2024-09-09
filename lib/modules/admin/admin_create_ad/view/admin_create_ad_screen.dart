import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/admin_custom_radio_button.dart';
import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../common/custom_textfield.dart';
import '../../../../common/file_image.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../helper/validators.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/responsive.dart';
import '../../../../utility/utility.dart';
import '../../../user/user_homepage/model/user_ads_list_data_model.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';
import '../admin_create_ad_controller.dart';

class AdminCreateAdScreen extends StatelessWidget {
  final adminCreateAdController = Get.find<AdminCreateAdController>();

  AdminCreateAdScreen({super.key});

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.thirtyEight,
                      right: Dimens.thirtyEight,
                      bottom: Dimens.fortyFive,
                      top: Dimens.twentyEight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: Dimens.seven),
                        child: CommonWidgets.autoSizeText(
                          text: 'add_ads'.tr,
                          textStyle: AppStyles.style24Bold.copyWith(
                              color: themeUtils.whiteBlackSwitchColor),
                          minFontSize: 16,
                          maxFontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Dimens.ten),
                        child: CommonWidgets.autoSizeText(
                          text: 'add_company_ads'.tr,
                          textStyle: AppStyles.style14Normal
                              .copyWith(color: themeUtils.primaryColorSwitch),
                          minFontSize: 16,
                          maxFontSize: 24,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Dimens.thirty),
                                  child: textFieldWithLabel(
                                    controller: adminCreateAdController
                                        .adNameController,
                                    hintText: 'ad_name'.tr,
                                    labelText: 'enter_ad_name'.tr,
                                    themeColorsUtil: themeUtils,
                                    obscureText: false,
                                    maxLines: 1,
                                  ),
                                ),
                                textFieldWithLabel(
                                  controller: adminCreateAdController
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
                                    visible: adminCreateAdController
                                            .preFilledAdDetailData.value ==
                                        null,
                                    replacement: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: Dimens.ten,
                                      children: List.generate(
                                        adminCreateAdController
                                                .preFilledAdDetailData
                                                .value
                                                ?.imageUrl
                                                ?.length ??
                                            0,
                                        (index) {
                                          return NxNetworkImage(
                                            imageUrl: adminCreateAdController
                                                    .preFilledAdDetailData
                                                    .value
                                                    ?.imageUrl?[index] ??
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
                                                  adminCreateAdController
                                                      .pickedFiles.length
                                              ? Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    NxFileImage(
                                                      file:
                                                          adminCreateAdController
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
                                                          adminCreateAdController
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
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          Responsive.isDesktop(
                                                                  context)
                                                              ? Dimens.twenty
                                                              : Dimens.twenty),
                                                  child: DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    dashPattern: const [10, 10],
                                                    color: themeUtils
                                                        .primaryColorSwitch,
                                                    strokeWidth: 1,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await adminCreateAdController
                                                            .pickImages();
                                                      },
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          Container(
                                                            width:
                                                                Dimens.hundred,
                                                            height:
                                                                Dimens.hundred,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: themeUtils
                                                                  .primaryColorSwitch
                                                                  .withOpacity(
                                                                      0.10),
                                                            ),
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                CommonWidgets
                                                                    .fromSvg(
                                                                  svgAsset:
                                                                      SvgAssets
                                                                          .uploadImageIcon,
                                                                  color: themeUtils
                                                                      .primaryColorSwitch,
                                                                ),
                                                                CommonWidgets
                                                                    .fromSvg(
                                                                  svgAsset:
                                                                      SvgAssets
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
                                                              text:
                                                                  'upload_image'
                                                                      .tr,
                                                              textAlign:
                                                                  TextAlign
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
                                                  ),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: Dimens.ten),
                                  child: textFieldWithLabel(
                                    controller: adminCreateAdController
                                        .adContentController,
                                    hintText: 'enter_description'.tr,
                                    labelText: 'enter_description'.tr,
                                    themeColorsUtil: themeUtils,
                                    obscureText: false,
                                    maxLines: 5,
                                  ),
                                ),
                                textFieldWithLabel(
                                  controller: adminCreateAdController
                                      .adManagerIdController,
                                  hintText: 'enter_manager_id'.tr,
                                  labelText: 'enter_manager_id_optional'.tr,
                                  themeColorsUtil: themeUtils,
                                  obscureText: false,
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: textFieldWithLabel(
                                          controller: adminCreateAdController
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
                                          controller: adminCreateAdController
                                              .adPriceController,
                                          hintText: 'amount'.tr,
                                          labelText: 'enter_price_amount'.tr,
                                          themeColorsUtil: themeUtils,
                                          obscureText: false,
                                          maxLines: 1,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(Validators
                                                    .numberPatternWithPoint)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Preview Image Area
                          Obx(
                            () => Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimens.sixty,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Dimens.thirty,
                                          bottom: Dimens.twelve),
                                      child: CommonWidgets.autoSizeText(
                                        text: 'preview'.tr,
                                        textStyle: AppStyles.style16Normal
                                            .copyWith(
                                                color: themeUtils
                                                    .whiteBlackSwitchColor),
                                        minFontSize: 10,
                                        maxFontSize: 16,
                                      ),
                                    ),
                                    if (adminCreateAdController
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
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimens.twenty),
                                                  child: Image.network(
                                                    adminCreateAdController
                                                        .pickedFiles[
                                                            adminCreateAdController
                                                                .currentImageIndex
                                                                .value]
                                                        .path,
                                                    fit: BoxFit.fill,
                                                    width:
                                                        constraints.maxWidth /
                                                            2.5,
                                                    height:
                                                        constraints.maxWidth /
                                                            4.5,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      size: Dimens.twentyTwo,
                                                      color: ColorValues
                                                          .whiteColor,
                                                    ),
                                                    onPressed: () {
                                                      adminCreateAdController
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
                                                      color: ColorValues
                                                          .whiteColor,
                                                    ),
                                                    onPressed: () {
                                                      adminCreateAdController
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
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: themeUtils
                                                    .darkGrayOfWhiteSwitchColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.twenty)),
                                            width: constraints.maxWidth / 2.5,
                                            height: constraints.maxWidth / 4.5,
                                            child: Center(
                                              child: CommonWidgets.fromSvg(
                                                svgAsset:
                                                    SvgAssets.uploadImageIcon,
                                                width: 80,
                                                height: 80,
                                                color: themeUtils
                                                    .primaryColorSwitch,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: Dimens.ten,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                size: Dimens.twentyTwo,
                                                color: ColorValues.whiteColor,
                                              ),
                                              onPressed: () {
                                                adminCreateAdController
                                                    .nextImage();
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            left: Dimens.ten,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.arrow_back,
                                                size: Dimens.twentyTwo,
                                                color: ColorValues.whiteColor,
                                              ),
                                              onPressed: () {
                                                adminCreateAdController
                                                    .previousImage();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Dimens.thirtyFive,
                                          bottom: Dimens.twentyFive,
                                          left: Dimens.fifteen),
                                      child: CommonWidgets.autoSizeText(
                                        text: 'status'.tr,
                                        textStyle: AppStyles.style18Bold
                                            .copyWith(
                                                color: themeUtils
                                                    .whiteBlackSwitchColor),
                                        minFontSize: 10,
                                        maxFontSize: 18,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        adminCreateAdController
                                            .adminCustomStatus.length,
                                        (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: Dimens.fifteen,
                                                bottom: Dimens.fifteen),
                                            child: AdminCustomRadioButton(
                                              themeColorsUtil: themeUtils,
                                              controller:
                                                  adminCreateAdController
                                                      .selectedAdStatus,
                                              status: adminCreateAdController
                                                  .adminCustomStatus[index],
                                              // Pass the correct status
                                              labelText: AppUtility.capitalizeStatus(
                                                  adminCreateAdController
                                                          .adminCustomStatus[
                                                      index]), // Generate label text dynamically
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      if (adminCreateAdController.preFilledAdDetailData.value ==
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
                                child: CustomButton(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.thirty),
                                  margin: EdgeInsets.only(right: Dimens.seven),
                                  btnText: 'cancel'.tr,
                                  isShowShadow: false,
                                  btnTextColor:
                                      themeUtils.blackWhiteSwitchColor,
                                  contentPadding: EdgeInsets.only(
                                    top: Dimens.ten,
                                    bottom: Dimens.ten,
                                    left: Dimens.twentyFour,
                                    right: Dimens.twentyFour,
                                  ),
                                ),
                              ),

                              /// Submit Button
                              InkWell(
                                onTap: () async {
                                  // Check if the number of picked images is less than required
                                  if (adminCreateAdController
                                      .adNameController.text
                                      .trim()
                                      .isEmpty) {
                                    AppUtility.showSnackBar(
                                        'please_enter_ad_name'.tr);
                                  } else if (adminCreateAdController
                                      .byCompanyNameController.text
                                      .trim()
                                      .isEmpty) {
                                    AppUtility.showSnackBar(
                                        'please_enter_ad_company'.tr);
                                  } else if (adminCreateAdController
                                          .pickedFiles.length <
                                      4) {
                                    AppUtility.showSnackBar(
                                        'please_upload_all_images'.tr);
                                  } else if (adminCreateAdController
                                      .adContentController.text
                                      .trim()
                                      .isEmpty) {
                                    AppUtility.showSnackBar(
                                        'please_enter_ad_content'.tr);
                                  } else if (adminCreateAdController
                                      .adLocationController.text
                                      .trim()
                                      .isEmpty) {
                                    AppUtility.showSnackBar(
                                        'please_enter_ad_location'.tr);
                                  } else if (adminCreateAdController
                                      .adPriceController.text
                                      .trim()
                                      .isEmpty) {
                                    AppUtility.showSnackBar(
                                        'please_enter_ad_price'.tr);
                                  } else {
                                    // Get the user ID
                                    String? adminId =
                                        await adminCreateAdController
                                            .getAdminUid();

                                    UserAdsListDataModel adDataModel =
                                        UserAdsListDataModel(
                                      docId: adminCreateAdController
                                          .adsDetailData.value?.docId,
                                      adName: adminCreateAdController
                                          .adNameController.text,
                                      byCompany: adminCreateAdController
                                          .byCompanyNameController.text,
                                      imageUrl: [],
                                      adManagerId: adminCreateAdController
                                              .adManagerIdController
                                              .text
                                              .isEmpty
                                          ? 'By Admin'
                                          : adminCreateAdController
                                              .adManagerIdController.text,
                                      addedDate: DateTime.now(),
                                      adContent: adminCreateAdController
                                          .adContentController.text,
                                      adStatus: adminCreateAdController
                                          .selectedAdStatus.value,
                                      adPrice: num.parse(adminCreateAdController
                                          .adPriceController.text),
                                      adLocation: adminCreateAdController
                                          .adLocationController.text,
                                    );
                                    String? documentId =
                                        await adminCreateAdController
                                            .storeAdminCreatedAds(
                                      adminSubmitAdDataModel: adDataModel,
                                      adminId: adminId,
                                    );
                                    print("documentId : $documentId");
                                    if (documentId != null) {
                                      RouteManagement.goToBack();
                                      AppUtility.showSnackBar(
                                          'task_submitted_successfully'.tr);
                                      adminCreateAdController
                                          .clearControllers();
                                    } else {
                                      AppUtility.showSnackBar(
                                          'something_went_wrong'.tr);
                                    }
                                  }
                                },
                                child: CustomButton(
                                  isShowShadow: false,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.thirty),
                                  btnText: 'submit'.tr,
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
      required TextEditingController controller,
      List<TextInputFormatter>? inputFormatters}) {
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
            inputFormatters: inputFormatters,
            borderSide:
                BorderSide(color: themeColorsUtil.adsTextFieldBorderColor),
            fillColor: ColorValues.transparent,
            hintStyle: const TextStyle(color: ColorValues.lightGrayColor),
          ),
        )
      ],
    );
  }
/*
  Widget customRadioButton({
    required ThemeColorsUtil themeUtils,
    required ValueNotifier<String> controller,
    required String status,
    double? btnSize,
    required String labelText,
    TextStyle? labelTextStyle,
    EdgeInsets? labelPadding,
  }) {
    return ValueListenableBuilder<String>(
      valueListenable: controller,
      builder: (context, currentStatus, child) {
        return GestureDetector(
          onTap: () {
            controller.value = status;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                currentStatus == status
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: btnSize ?? Dimens.twenty,
                color: themeUtils.primaryColorSwitch,
              ),
              Padding(
                padding: labelPadding ?? EdgeInsets.only(left: Dimens.sixTeen),
                child: Text(
                  labelText,
                  style: labelTextStyle ??
                      AppStyles.style16Normal
                          .copyWith(color: themeUtils.whiteBlackSwitchColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }*/
}
