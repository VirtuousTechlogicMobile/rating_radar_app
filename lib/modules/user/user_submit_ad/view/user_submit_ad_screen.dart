import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/modules/user/header/bindings/header_binding.dart';
import 'package:RatingRadar_app/modules/user/user_submit_ad/model/user_submit_ad_data_model.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/file_image.dart';
import '../../../../constant/dimens.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../user_submit_ad_controller.dart';

class UserSubmitAdScreen extends StatelessWidget {
  final String adDocumentId;
  final userSubmitAdController = Get.find<UserSubmitAdController>();

  UserSubmitAdScreen({super.key, required this.adDocumentId}) {
    userSubmitAdController.getAdsDetailData(docId: adDocumentId);
  }

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
    HeaderBinding().dependencies();
    return HeaderView(
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
            margin: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.fortyThree, top: Dimens.twenty),
            decoration: BoxDecoration(
              color: themeUtils.drawerBgWhiteSwitchColor,
              borderRadius: BorderRadius.circular(Dimens.thirty),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  spreadRadius: 0,
                  blurRadius: 50,
                  color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
                ),
              ],
            ),
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.thirty),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.fortyThree, top: Dimens.twentyEight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.seven),
                          child: CommonWidgets.autoSizeText(
                            text: userSubmitAdController.adsDetailData.value?.adName ?? '',
                            textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: userSubmitAdController.adsDetailData.value?.byCompany ?? '',
                            textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                            minFontSize: 16,
                            maxFontSize: 24,
                          ),
                        ),

                        /// ad image
                        if (userSubmitAdController.adsDetailData.value?.imageUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimens.twenty),
                            child: CachedNetworkImage(
                              imageUrl: userSubmitAdController.adsDetailData.value!.imageUrl,
                              fit: BoxFit.fill,
                              width: constraints.maxWidth,
                              height: constraints.maxWidth / 2.5,
                            ),
                          ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'taskDetails'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        CommonWidgets.autoSizeText(
                          text: userSubmitAdController.adsDetailData.value?.adContent ?? '',
                          textStyle: AppStyles.style16Light.copyWith(color: themeUtils.whiteBlackSwitchColor),
                          minFontSize: 16,
                          maxFontSize: 16,
                          maxLines: 100,
                          textAlign: TextAlign.justify,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimens.fifteen),
                          child: CommonWidgets.autoSizeText(
                            text: 'submitTask'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),

                        Obx(
                          () => Wrap(
                            direction: Axis.horizontal,
                            spacing: Dimens.ten,
                            children: List.generate(
                              6,
                              (index) {
                                return index < userSubmitAdController.pickedFiles.length
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          NxFileImage(
                                            file: userSubmitAdController.pickedFiles[index] ?? XFile(''),
                                            width: Dimens.hundred,
                                            height: Dimens.hundred,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: InkWell(
                                              onTap: () {
                                                userSubmitAdController.removeImage(index);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: Dimens.twenty,
                                                color: themeUtils.primaryColorSwitch,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: const [10, 10],
                                        color: themeUtils.primaryColorSwitch,
                                        strokeWidth: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            await userSubmitAdController.pickImages();
                                          },
                                          child: Container(
                                            width: Dimens.hundred,
                                            height: Dimens.hundred,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(color: themeUtils.primaryColorSwitch.withOpacity(0.10)),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CommonWidgets.fromSvg(svgAsset: SvgAssets.uploadImageIcon),
                                                CommonWidgets.fromSvg(svgAsset: SvgAssets.uploadImageAddIcon),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: Dimens.fifteen, bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'comments'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: userSubmitAdController.commentsController,
                                borderRadius: BorderRadius.circular(Dimens.nineteen),
                                borderSide: BorderSide(color: themeUtils.whiteBlackSwitchColor, width: 1),
                                maxLines: 2,
                                fillColor: ColorValues.transparent,
                              ),
                            ),
                            SizedBox(width: Dimens.fifty),
                            InkWell(
                              onTap: () {
                                RouteManagement.goToBack();
                              },
                              child: SizedBox(
                                width: Dimens.hundred,
                                child: CustomButton(
                                  borderRadius: BorderRadius.circular(Dimens.hundred),
                                  btnText: 'cancel'.tr,
                                ),
                              ),
                            ),
                            SizedBox(width: Dimens.twenty),
                            InkWell(
                              onTap: () async {
                                if (userSubmitAdController.pickedFiles.length < 6) {
                                  AppUtility.showSnackBar('please_upload_all_images'.tr);
                                } else {
                                  String userId = await userSubmitAdController.getUid();
                                  userSubmitAdController.storeUserSubmittedAds(
                                    userSubmitAdDataModel: UserSubmitAdDataModel(
                                        adId: userSubmitAdController.adsDetailData.value?.docId ?? '',
                                        uId: userId,
                                        addedDate: DateTime.now(),
                                        comments: '',
                                        status: CustomStatus.pending),
                                  );
                                }
                              },
                              child: SizedBox(
                                width: Dimens.hundred,
                                child: CustomButton(
                                  borderRadius: BorderRadius.circular(Dimens.hundred),
                                  btnText: 'submit'.tr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
