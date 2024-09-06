import 'package:RatingRadar_app/common/cached_network_image.dart';
import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/common/custom_textfield.dart';
import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/modules/user/user_submit_ad/model/user_submit_ad_data_model.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
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
    userSubmitAdController.getTotalSubmittedAdsCount(adId: adDocumentId);
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
                        if (userSubmitAdController
                                .adsDetailData.value?.imageUrl !=
                            null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ads images layout
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Dimens.thirtyTwo,
                                    bottom: Dimens.twenty),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(Dimens.twenty),
                                      child: NxNetworkImage(
                                        imageUrl: userSubmitAdController
                                                .adsDetailData
                                                .value!
                                                .imageUrl?[0] ??
                                            '',
                                        imageFit: BoxFit.fill,
                                        width: constraints.maxWidth / 2.5,
                                        height: constraints.maxWidth / 4.5,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: Dimens.twenty),
                                      child: SizedBox(
                                        width: constraints.maxWidth / 2.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              userSubmitAdController
                                                          .adsDetailData
                                                          .value!
                                                          .imageUrl!
                                                          .length <=
                                                      3
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment
                                                      .spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            if (userSubmitAdController
                                                        .adsDetailData
                                                        .value
                                                        ?.imageUrl
                                                        ?.length !=
                                                    null &&
                                                userSubmitAdController
                                                        .adsDetailData
                                                        .value!
                                                        .imageUrl!
                                                        .length >
                                                    4)
                                              InkWell(
                                                onTap: () {
                                                  if (userSubmitAdController
                                                          .currentImageIndex
                                                          .value >
                                                      1) {
                                                    userSubmitAdController
                                                        .currentImageIndex
                                                        .value--;
                                                  }
                                                },
                                                child: Container(
                                                  height: Dimens.thirtySix,
                                                  width: Dimens.thirtySix,
                                                  decoration: BoxDecoration(
                                                    color: themeUtils
                                                        .primaryColorSwitch
                                                        .withOpacity(0.10),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    size: Dimens.twentyTwo,
                                                    color: themeUtils
                                                        .primaryColorSwitch,
                                                  ),
                                                ),
                                              ),
                                            ...List.generate(
                                              userSubmitAdController
                                                      .adsDetailData
                                                      .value
                                                      ?.imageUrl
                                                      ?.length ??
                                                  0,
                                              (index) {
                                                if (index >=
                                                        userSubmitAdController
                                                            .currentImageIndex
                                                            .value &&
                                                    index <
                                                        (userSubmitAdController
                                                                .currentImageIndex
                                                                .value +
                                                            3)) {
                                                  return Padding(
                                                    padding:
                                                        userSubmitAdController
                                                                    .adsDetailData
                                                                    .value!
                                                                    .imageUrl!
                                                                    .length <=
                                                                3
                                                            ? EdgeInsets.only(
                                                                right:
                                                                    Dimens.ten)
                                                            : EdgeInsets.zero,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimens.twentyTwo),
                                                      child: NxNetworkImage(
                                                        imageUrl: userSubmitAdController
                                                                    .adsDetailData
                                                                    .value
                                                                    ?.imageUrl?[
                                                                index] ??
                                                            '',
                                                        height: Dimens
                                                            .oneHundredNine,
                                                        width: Dimens
                                                            .oneHundredNineteen,
                                                        imageFit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ).where((widget) =>
                                                widget is! Container),
                                            if (userSubmitAdController
                                                        .adsDetailData
                                                        .value
                                                        ?.imageUrl
                                                        ?.length !=
                                                    null &&
                                                userSubmitAdController
                                                        .adsDetailData
                                                        .value!
                                                        .imageUrl!
                                                        .length >
                                                    4)
                                              InkWell(
                                                onTap: () {
                                                  if (userSubmitAdController
                                                          .currentImageIndex
                                                          .value <
                                                      (userSubmitAdController
                                                              .adsDetailData
                                                              .value!
                                                              .imageUrl!
                                                              .length -
                                                          3)) {
                                                    userSubmitAdController
                                                        .currentImageIndex
                                                        .value++;
                                                  }
                                                },
                                                child: Container(
                                                  height: Dimens.thirtySix,
                                                  width: Dimens.thirtySix,
                                                  decoration: BoxDecoration(
                                                    color: themeUtils
                                                        .primaryColorSwitch
                                                        .withOpacity(0.10),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    size: Dimens.twentyTwo,
                                                    color: themeUtils
                                                        .primaryColorSwitch,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /// ads content layout
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.eight),
                                      child: CommonWidgets.autoSizeText(
                                        text: userSubmitAdController
                                                .adsDetailData.value?.adName ??
                                            '',
                                        textStyle: AppStyles.style29SemiBold
                                            .copyWith(
                                                color: themeUtils
                                                    .primaryColorSwitch),
                                        minFontSize: 20,
                                        maxFontSize: 29,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Dimens.fourteen),
                                      child: CommonWidgets.autoSizeText(
                                        text: userSubmitAdController
                                                .adsDetailData
                                                .value
                                                ?.byCompany ??
                                            '',
                                        textStyle: AppStyles.style15Normal
                                            .copyWith(
                                                color: themeUtils
                                                    .whiteBlackSwitchColor
                                                    .withOpacity(0.50)),
                                        minFontSize: 8,
                                        maxFontSize: 15,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ...List.generate(
                                          5,
                                          (index) {
                                            return CommonWidgets.fromSvg(
                                              svgAsset:
                                                  SvgAssets.ratingStarIcon,
                                              margin: EdgeInsets.only(
                                                  right: Dimens.five),
                                              color: index < 4
                                                  ? ColorValues
                                                      .ratingStarYellowColor
                                                  : ColorValues
                                                      .lightGrayC4Color,
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Dimens.three,
                                              right: Dimens.nine),
                                          child: CommonWidgets.autoSizeText(
                                            text: '4.5',
                                            textStyle: AppStyles.style15Bold
                                                .copyWith(
                                                    color: themeUtils
                                                        .whiteBlackSwitchColor),
                                            minFontSize: 15,
                                            maxFontSize: 15,
                                          ),
                                        ),
                                        Flexible(
                                          child: CommonWidgets.autoSizeText(
                                            text: 'from 392 Reviews',
                                            textStyle: AppStyles.style15Normal
                                                .copyWith(
                                                    color: themeUtils
                                                        .whiteBlackSwitchColor
                                                        .withOpacity(0.50)),
                                            minFontSize: 15,
                                            maxFontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimens.ten),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimens.five),
                                            child: Text(
                                              'Rs.',
                                              style: AppStyles.style21SemiBold
                                                  .copyWith(
                                                      color: themeUtils
                                                          .whiteBlackSwitchColor
                                                          .withOpacity(0.50)),
                                            ),
                                          ),
                                          Text(
                                            userSubmitAdController.adsDetailData
                                                    .value?.adPrice
                                                    .toString() ??
                                                '',
                                            style: AppStyles.style40SemiBold
                                                .copyWith(
                                                    color: themeUtils
                                                        .whiteBlackSwitchColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: Dimens.fifty),
                                        child: Text(
                                          userSubmitAdController.adsDetailData
                                                  .value?.adContent ??
                                              '',
                                          style: AppStyles.style18Normal
                                              .copyWith(
                                                  color: themeUtils
                                                      .whiteBlackSwitchColor
                                                      .withOpacity(0.50)),
                                          maxLines: 11,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Padding(
                                        padding:
                                            EdgeInsets.only(top: Dimens.ten),
                                        child: Text(
                                          '${userSubmitAdController.totalSubmittedAdsCount.value} ${'submitted_in_the_last_24_hours'.tr}',
                                          style: AppStyles.style14SemiBold600
                                              .copyWith(
                                                  color: themeUtils
                                                      .primaryColorSwitch),
                                          maxLines: 11,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimens.thirty, bottom: Dimens.fifteen),
                          child: CommonWidgets.autoSizeText(
                            text: 'submit_task'.tr,
                            textStyle: AppStyles.style18Bold.copyWith(
                                color: themeUtils.whiteBlackSwitchColor),
                            minFontSize: 8,
                            maxFontSize: 18,
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: userSubmitAdController
                                    .preFilledAdDetailData.value ==
                                null,
                            replacement: Wrap(
                              direction: Axis.horizontal,
                              spacing: Dimens.ten,
                              children: List.generate(
                                userSubmitAdController.preFilledAdDetailData
                                        .value?.imageList?.length ??
                                    0,
                                (index) {
                                  return NxNetworkImage(
                                    imageUrl: userSubmitAdController
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
                                6,
                                (index) {
                                  return index <
                                          userSubmitAdController
                                              .pickedFiles.length
                                      ? Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            NxFileImage(
                                              file: userSubmitAdController
                                                      .pickedFiles[index] ??
                                                  XFile(''),
                                              width: Dimens.hundred,
                                              height: Dimens.hundred,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  userSubmitAdController
                                                      .removeImage(index);
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
                                          color: themeUtils.primaryColorSwitch,
                                          strokeWidth: 1,
                                          child: InkWell(
                                            onTap: () async {
                                              await userSubmitAdController
                                                  .pickImages();
                                            },
                                            child: Container(
                                              width: Dimens.hundred,
                                              height: Dimens.hundred,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: themeUtils
                                                      .primaryColorSwitch
                                                      .withOpacity(0.10)),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CommonWidgets.fromSvg(
                                                      svgAsset: SvgAssets
                                                          .uploadImageIcon,
                                                      color: themeUtils
                                                          .primaryColorSwitch),
                                                  CommonWidgets.fromSvg(
                                                      svgAsset: SvgAssets
                                                          .uploadImageAddIcon,
                                                      color: themeUtils
                                                          .primaryColorSwitch),
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
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller:
                                    userSubmitAdController.commentsController,
                                isReadOnly: userSubmitAdController
                                        .preFilledAdDetailData.value !=
                                    null,
                                borderRadius:
                                    BorderRadius.circular(Dimens.nineteen),
                                borderSide: BorderSide(
                                    color: themeUtils.whiteBlackSwitchColor,
                                    width: 1),
                                maxLines: 2,
                                fillColor: ColorValues.transparent,
                              ),
                            ),
                          ],
                        ),
                        if (userSubmitAdController
                                .preFilledAdDetailData.value ==
                            null)
                          Padding(
                            padding: EdgeInsets.only(
                                top: Dimens.oneHundredEightyFive),
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
                                    width: Dimens.twoHundredSeven,
                                    child: CustomButton(
                                      borderRadius:
                                          BorderRadius.circular(Dimens.thirty),
                                      margin:
                                          EdgeInsets.only(right: Dimens.seven),
                                      btnText: 'cancel'.tr,
                                    ),
                                  ),
                                ),

                                /// submit button
                                InkWell(
                                  onTap: () async {
                                    if (userSubmitAdController
                                            .pickedFiles.length <
                                        6) {
                                      AppUtility.showSnackBar(
                                          'please_upload_all_images'.tr);
                                    } else {
                                      String userId =
                                          await userSubmitAdController.getUid();
                                      String? documentId =
                                          await userSubmitAdController
                                              .storeUserSubmittedAds(
                                        userSubmitAdDataModel:
                                            UserSubmitAdDataModel(
                                          adId: userSubmitAdController
                                                  .adsDetailData.value?.docId ??
                                              '',
                                          uId: userId,
                                          addedDate: DateTime.now(),
                                          comments: userSubmitAdController
                                              .commentsController.text,
                                          status: CustomStatus.pending
                                              .toLowerCase(),
                                          adName: userSubmitAdController
                                                  .adsDetailData
                                                  .value
                                                  ?.adName ??
                                              '',
                                          company: userSubmitAdController
                                                  .adsDetailData
                                                  .value
                                                  ?.byCompany ??
                                              '',
                                          adPrice: userSubmitAdController
                                                  .adsDetailData
                                                  .value
                                                  ?.adPrice ??
                                              0,
                                        ),
                                      );
                                      if (documentId != null) {
                                        RouteManagement.goToBack();
                                        AppUtility.showSnackBar(
                                            'task_submitted_successfully'.tr);
                                      } else {
                                        AppUtility.showSnackBar(
                                            'something_want_wrong'.tr);
                                      }
                                    }
                                  },
                                  child: SizedBox(
                                    width: Dimens.twoHundredSeven,
                                    child: CustomButton(
                                      borderRadius:
                                          BorderRadius.circular(Dimens.thirty),
                                      margin:
                                          EdgeInsets.only(left: Dimens.seven),
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
            ),
          );
        },
      ),
    );
  }
}
