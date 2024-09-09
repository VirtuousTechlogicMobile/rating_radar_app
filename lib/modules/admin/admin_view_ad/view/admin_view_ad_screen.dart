import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/modules/admin/admin_view_ad/admin_view_ad_controller.dart';
import 'package:RatingRadar_app/modules/user/user_submit_ad/model/user_submit_ad_data_model.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/admin_custom_radio_button.dart';
import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';

class AdminViewAdScreen extends StatelessWidget {
  final String adDocumentId;
  final adminViewAdController = Get.find<AdminViewAdController>();

  AdminViewAdScreen({super.key, required this.adDocumentId}) {
    adminViewAdController.getAdsDetailData(docId: adDocumentId);
    adminViewAdController.getTotalSubmittedAdsCount(adId: adDocumentId);
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
            child: Obx(
              () => ClipRRect(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: Dimens.thirtyTwo,
                                  bottom: Dimens.twenty),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ads name
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimens.eight),
                                    child: CommonWidgets.autoSizeText(
                                      text: adminViewAdController
                                              .adsDetailData.value?.adName ??
                                          '',
                                      textStyle: AppStyles.style24Bold.copyWith(
                                          color:
                                              themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 20,
                                      maxFontSize: 24,
                                    ),
                                  ),
                                  // company name
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: Dimens.fourteen),
                                    child: CommonWidgets.autoSizeText(
                                      text: adminViewAdController
                                              .adsDetailData.value?.byCompany ??
                                          '',
                                      textStyle: AppStyles.style14Normal
                                          .copyWith(
                                              color: themeUtils
                                                  .primaryColorSwitch),
                                      minFontSize: 8,
                                      maxFontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimens.oneHundredEightyTwo,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: adminViewAdController
                                              .adsDetailData
                                              .value
                                              ?.imageUrl
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        String imageUrl = adminViewAdController
                                                .adsDetailData
                                                .value
                                                ?.imageUrl?[index] ??
                                            '';
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: Dimens
                                                  .twentyFive), // Add spacing between images
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimens.twenty),
                                            child: NxNetworkImage(
                                              imageUrl: imageUrl,
                                              imageFit: BoxFit.fill,
                                              width: Dimens.threeHundred,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.twenty, bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'task_details'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimens.fifty),
                          child: Text(
                            adminViewAdController
                                    .adsDetailData.value?.adContent ??
                                '',
                            style: AppStyles.style16Light.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            maxLines: 11,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.thirty, bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'comments'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: constraints.maxWidth / 1.65,
                              height: constraints.maxWidth / 3.5,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Dimens.twentyTwo,
                                      right: Dimens.forty,
                                      left: Dimens.twentyFive),
                                  child: Column(
                                    // Wrap in a Column to display the list of comments
                                    children: List.generate(
                                      adminViewAdController.commentsData.length,
                                      (index) {
                                        var comment =
                                            adminViewAdController.commentsData[
                                                index]; // Access comment data
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // User Avatar
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.blue,
                                              child: Text(
                                                comment['username']![
                                                    0], // Accessing first character of username
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            // User Comment and Details
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Username
                                                  Text(
                                                    comment['username']!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  // Comment Content
                                                  Text(
                                                    comment['content']!,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(height: 12),
                                                  Divider(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimens.twenty),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: Dimens.twenty),
                                    child: CommonWidgets.autoSizeText(
                                      text: 'status'.tr,
                                      textStyle: AppStyles.style18Bold.copyWith(
                                          color:
                                              themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 8,
                                      maxFontSize: 18,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      adminViewAdController
                                          .adminCustomStatus.length,
                                      (index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: Dimens.fifteen),
                                          child: AdminCustomRadioButton(
                                            themeColorsUtil: themeUtils,

                                            controller: adminViewAdController
                                                .selectedAdStatus,
                                            status: adminViewAdController
                                                .adminCustomStatus[index],
                                            // Pass the correct status
                                            labelText: AppUtility.capitalizeStatus(
                                                adminViewAdController
                                                        .adminCustomStatus[
                                                    index]), // Generate label text dynamically
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Dimens.oneHundredFifty),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        /// cancel button
                                        InkWell(
                                          onTap: () {
                                            RouteManagement.goToBack();
                                          },
                                          child: CustomButton(
                                            isShowShadow: false,
                                            contentPadding: EdgeInsets.only(
                                                top: Dimens.ten,
                                                bottom: Dimens.ten,
                                                left: Dimens.twentyFour,
                                                right: Dimens.twentyFour),
                                            borderRadius: BorderRadius.circular(
                                                Dimens.thirty),
                                            margin: EdgeInsets.only(
                                                right: Dimens.seven),
                                            btnText: 'cancel'.tr,
                                          ),
                                        ),

                                        /// submit button
                                        InkWell(
                                          onTap: () async {
                                            if (adminViewAdController
                                                    .pickedFiles.length <
                                                6) {
                                              AppUtility.showSnackBar(
                                                  'please_upload_all_images'
                                                      .tr);
                                            } else {
                                              String userId =
                                                  await adminViewAdController
                                                      .getUid();
                                              String? documentId =
                                                  await adminViewAdController
                                                      .storeUserSubmittedAds(
                                                userSubmitAdDataModel:
                                                    UserSubmitAdDataModel(
                                                  adId: adminViewAdController
                                                          .adsDetailData
                                                          .value
                                                          ?.docId ??
                                                      '',
                                                  uId: userId,
                                                  addedDate: DateTime.now(),
                                                  comments:
                                                      adminViewAdController
                                                          .commentsController
                                                          .text,
                                                  status: CustomStatus.pending
                                                      .toLowerCase(),
                                                  adName: adminViewAdController
                                                          .adsDetailData
                                                          .value
                                                          ?.adName ??
                                                      '',
                                                  company: adminViewAdController
                                                          .adsDetailData
                                                          .value
                                                          ?.byCompany ??
                                                      '',
                                                  adPrice: adminViewAdController
                                                          .adsDetailData
                                                          .value
                                                          ?.adPrice ??
                                                      0,
                                                ),
                                              );
                                              if (documentId != null) {
                                                RouteManagement.goToBack();
                                                AppUtility.showSnackBar(
                                                    'task_submitted_successfully'
                                                        .tr);
                                              } else {
                                                AppUtility.showSnackBar(
                                                    'something_want_wrong'.tr);
                                              }
                                            }
                                          },
                                          child: CustomButton(
                                            isShowShadow: false,
                                            contentPadding: EdgeInsets.only(
                                                top: Dimens.ten,
                                                bottom: Dimens.ten,
                                                left: Dimens.twentyFour,
                                                right: Dimens.twentyFour),
                                            borderRadius: BorderRadius.circular(
                                                Dimens.thirty),
                                            margin: EdgeInsets.only(
                                                left: Dimens.seven),
                                            btnText: 'submit'.tr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
