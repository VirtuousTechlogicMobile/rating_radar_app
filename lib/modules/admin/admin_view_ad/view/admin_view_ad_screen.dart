import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/modules/admin/admin_view_ad/admin_view_ad_controller.dart';
import 'package:RatingRadar_app/modules/admin/admin_view_ad/component/admin_block_ad_reason.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/custom_radio_button.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/responsive.dart';
import '../../admin_header/view/admin_header_view.dart';
import '../../drawer/view/admin_drawer_view.dart';

class AdminViewAdScreen extends StatelessWidget {
  final String adDocumentId;
  final adminViewAdController = Get.find<AdminViewAdController>();

  AdminViewAdScreen({super.key, required this.adDocumentId}) {
    adminViewAdController.getAdsDetailData(docId: adDocumentId);
    adminViewAdController.getTotalSubmittedAdsCount(adId: adDocumentId);
    adminViewAdController.getUserList(adId: adDocumentId);
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
            margin: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.fortyFive, top: Dimens.thirtyEight),
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
                    padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.fortyFive, top: Dimens.twentyEight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: Dimens.thirtyTwo, bottom: Dimens.twenty),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ads name
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: Dimens.eight),
                                    child: CommonWidgets.autoSizeText(
                                      text: adminViewAdController.adsDetailData.value?.adName ?? '',
                                      textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                      minFontSize: 20,
                                      maxFontSize: 24,
                                    ),
                                  ),
                                  // company name
                                  Padding(
                                    padding: EdgeInsets.only(bottom: Dimens.fourteen),
                                    child: CommonWidgets.autoSizeText(
                                      text: adminViewAdController.adsDetailData.value?.byCompany ?? '',
                                      textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                                      minFontSize: 8,
                                      maxFontSize: 14,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: Dimens.twenty),
                                    child: Row(
                                      mainAxisAlignment:
                                          (adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0) <= 3 ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if ((adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0) > 4)
                                          InkWell(
                                            onTap: () {
                                              if (adminViewAdController.currentImageIndex.value > 0) {
                                                adminViewAdController.currentImageIndex.value--;
                                              }
                                            },
                                            child: Container(
                                              height: Dimens.thirtySix,
                                              width: Dimens.thirtySix,
                                              decoration: BoxDecoration(
                                                color: themeUtils.primaryColorSwitch.withOpacity(0.10),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.arrow_back,
                                                size: Dimens.twentyTwo,
                                                color: themeUtils.primaryColorSwitch,
                                              ),
                                            ),
                                          ),
                                        ...List.generate(
                                          (adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0),
                                          (index) {
                                            if (index >= adminViewAdController.currentImageIndex.value && index < (adminViewAdController.currentImageIndex.value + 3)) {
                                              return Padding(
                                                padding:
                                                    (adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0) <= 3 ? EdgeInsets.only(right: Dimens.ten) : EdgeInsets.zero,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(Dimens.twentyTwo),
                                                  child: NxNetworkImage(
                                                    imageUrl: adminViewAdController.adsDetailData.value?.imageUrl?[index] ?? '',
                                                    height: Dimens.oneHundredEightyTwo,
                                                    width: Dimens.threeHundred,
                                                    imageFit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink(); // More efficient than Container()
                                            }
                                          },
                                        ),
                                        if ((adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0) > 4)
                                          InkWell(
                                            onTap: () {
                                              if (adminViewAdController.currentImageIndex.value < ((adminViewAdController.adsDetailData.value?.imageUrl?.length ?? 0) - 3)) {
                                                adminViewAdController.currentImageIndex.value++;
                                              }
                                            },
                                            child: Container(
                                              height: Dimens.thirtySix,
                                              width: Dimens.thirtySix,
                                              decoration: BoxDecoration(
                                                color: themeUtils.primaryColorSwitch.withOpacity(0.10),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                size: Dimens.twentyTwo,
                                                color: themeUtils.primaryColorSwitch,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.twenty, bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'task_details'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Dimens.fifty),
                          child: Text(
                            adminViewAdController.adsDetailData.value?.adContent ?? '',
                            style: AppStyles.style16Light.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            maxLines: 11,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.twenty, bottom: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'comments'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        Obx(
                          () {
                            var comments = adminViewAdController.userCommentedList;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Responsive.isDesktop(context) ? constraints.maxWidth / 1.65 : constraints.maxWidth,
                                  height: constraints.maxHeight / 1.5,
                                  // Ensure the container has sufficient height
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: comments.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: Dimens.sixtyFive),
                                            child: CommonWidgets.autoSizeText(
                                              text: 'no_data_available_right_now'.tr,
                                              textStyle: AppStyles.style35SemiBold.copyWith(color: ColorValues.noDataTextColor),
                                              minFontSize: 15,
                                              maxFontSize: 35,
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: Dimens.twentyTwo,
                                              right: Dimens.fifty,
                                              left: Dimens.twentyEight,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: List.generate(
                                                comments.length,
                                                (index) {
                                                  var comment = comments[index];
                                                  return Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                if (comment.userProfileImage != '' && comment.userProfileImage.isEmpty)
                                                                  NxNetworkImage(
                                                                    imageUrl: comment.userProfileImage,
                                                                    width: Dimens.fortyEight,
                                                                    height: Dimens.fortyEight,
                                                                    imageFit: BoxFit.cover,
                                                                  )
                                                                else
                                                                  Container(
                                                                    width: Dimens.fortyEight,
                                                                    height: Dimens.fortyEight,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: themeUtils.primaryColorSwitch, // Background color for the circle
                                                                    ),
                                                                    alignment: Alignment.center,
                                                                    child: Text(
                                                                      comment.username.substring(0, 1).toUpperCase(),
                                                                      style: TextStyle(
                                                                        fontSize: Dimens.twenty,
                                                                        // Adjust the font size as needed
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                  width: Dimens.ten,
                                                                ),
                                                                CommonWidgets.autoSizeText(
                                                                    text: comment.username,
                                                                    textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                                                    minFontSize: 8,
                                                                    maxFontSize: 18),
                                                              ],
                                                            ),
                                                            const SizedBox(height: 4),
                                                            CommonWidgets.autoSizeText(
                                                                text: comment.comment,
                                                                textStyle: AppStyles.style16Light.copyWith(color: themeUtils.commentViewAdColor, fontWeight: FontWeight.w300),
                                                                minFontSize: 8,
                                                                maxLines: 3,
                                                                maxFontSize: 18),
                                                            Padding(
                                                              padding: EdgeInsets.only(bottom: Dimens.fifteen, top: Dimens.fifteen),
                                                              child: const Divider(
                                                                color: ColorValues.dividerColor,
                                                              ),
                                                            ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: Dimens.twenty),
                                        child: CommonWidgets.autoSizeText(
                                          text: 'action'.tr,
                                          textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                          minFontSize: 8,
                                          maxFontSize: 18,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          adminViewAdController.adminActionsList.length,
                                          (index) {
                                            bool shouldDisplay = adminViewAdController.shouldDisplayOption(index, adminViewAdController.selectedActionIndex.value);
                                            return shouldDisplay
                                                ? Padding(
                                                    padding: EdgeInsets.only(bottom: Dimens.fifteen),
                                                    child: Obx(
                                                      () => InkWell(
                                                        onTap: () {
                                                          if (index == 3 || index == 2) {
                                                            AdminBlockAdReasonComponent.adminBlockAdReasonDialogue(
                                                              context: context,
                                                              themeUtils: themeUtils,
                                                              onClose: () {
                                                                RouteManagement.goToBack();
                                                              },
                                                              onSubmit: (reasonText) {
                                                                if (reasonText.isNotEmpty) {
                                                                  adminViewAdController.selectedActionIndex.value = index;
                                                                  adminViewAdController.blocActionReasonController.text = reasonText;
                                                                  RouteManagement.goToBack();
                                                                } else {
                                                                  adminViewAdController.getActionConvertIndex(adminViewAdController.adsDetailData.value?.companyAdAction ?? '') ==
                                                                          index
                                                                      ? adminViewAdController
                                                                          .getActionConvertIndex(adminViewAdController.adsDetailData.value?.companyAdAction ?? '')
                                                                      : adminViewAdController.selectedActionIndex.value == index;
                                                                }
                                                              },
                                                              maxLines: 3,
                                                            );
                                                          } else {
                                                            adminViewAdController.selectedActionIndex.value = index;
                                                          }
                                                        },
                                                        child: CustomRadioButton(
                                                          isSelected: adminViewAdController.selectedActionIndex.value == index,
                                                          labelText: AppUtility.capitalizeStatus(adminViewAdController.adminActionsList[index]),
                                                          labelPadding: EdgeInsets.only(left: Dimens.five),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: Dimens.twenty, top: Dimens.twenty),
                                        child: CommonWidgets.autoSizeText(
                                          text: 'status'.tr,
                                          textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                          minFontSize: 8,
                                          maxFontSize: 18,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          adminViewAdController.adminStatusList.length,
                                          (index) {
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: Dimens.fifteen),
                                              child: Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    // Update selection based on index
                                                    adminViewAdController.selectedStatusIndex.value = index;
                                                  },
                                                  child: CustomRadioButton(
                                                    isSelected: adminViewAdController.selectedStatusIndex.value == index,
                                                    labelText: AppUtility.capitalizeStatus(adminViewAdController.adminStatusList[index]),
                                                    labelPadding: EdgeInsets.only(left: Dimens.five),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: Dimens.seventy),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            /// cancel button
                                            InkWell(
                                              onTap: () {
                                                RouteManagement.goToBack();
                                              },
                                              child: CustomButton(
                                                isShowShadow: false,
                                                contentPadding: EdgeInsets.only(top: Dimens.ten, bottom: Dimens.ten, left: Dimens.twentyFour, right: Dimens.twentyFour),
                                                borderRadius: BorderRadius.circular(Dimens.thirty),
                                                margin: EdgeInsets.only(right: Dimens.seven),
                                                btnText: 'cancel'.tr,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                int selectedAction = adminViewAdController.selectedActionIndex.value;
                                                int selectedStatus = adminViewAdController.selectedStatusIndex.value;

                                                String? documentId = await adminViewAdController.updateAdminCustomStatusAds(
                                                  adId: adDocumentId,
                                                  status: adminViewAdController.getStatusIndex(selectedStatus),
                                                  action: adminViewAdController.getActionIndex(selectedAction),
                                                  reason: adminViewAdController.blocActionReasonController.text, // Optional: Default reason if none is provided
                                                );

                                                // Check if the update was successful
                                                if (documentId != null && documentId.isNotEmpty) {
                                                  // Navigate back and show success message
                                                  RouteManagement.goToBack();
                                                  AppUtility.showSnackBar('task_submitted_successfully'.tr);
                                                } else {
                                                  // Show error message if the update failed
                                                  AppUtility.showSnackBar('something_went_wrong'.tr);
                                                }
                                              },
                                              child: CustomButton(
                                                isShowShadow: false,
                                                contentPadding: EdgeInsets.only(
                                                  top: Dimens.ten,
                                                  bottom: Dimens.ten,
                                                  left: Dimens.twentyFour,
                                                  right: Dimens.twentyFour,
                                                ),
                                                borderRadius: BorderRadius.circular(Dimens.thirty),
                                                margin: EdgeInsets.only(left: Dimens.seven),
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
                            );
                          },
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
