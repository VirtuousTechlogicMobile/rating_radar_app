import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../homepage/model/admin_ads_list_data_model.dart';
import 'model/admin_submit_ad_data_model.dart';

class AdminSubmitAdController extends GetxController {
  Rx<AdminAdsListDataModel?> adsDetailData =
      (null as AdminAdsListDataModel?).obs;
  Rx<AdminSubmitAdDataModel?> preFilledAdDetailData =
      (null as AdminSubmitAdDataModel?).obs;
  RxList<XFile> pickedFiles = <XFile>[].obs;
  TextEditingController commentsController = TextEditingController();

  RxInt currentImageIndex = 1.obs;
  RxInt totalSubmittedAdsCount = 0.obs;

  Future<String> getUid() async {
    return await PreferencesManager.getUserId() ?? '';
  }

  Future pickImages() async {
    try {
      List<XFile> files = await ImagePicker().pickMultiImage(
        limit: 6,
      );
      if (pickedFiles.length < 6) {
        for (var file in files) {
          pickedFiles.add(file);
        }
      }
      pickedFiles.refresh();
    } catch (e) {
      log("Exception : $e");
      return null;
    }
  }

  Future removeImage(int index) async {
    pickedFiles.removeAt(index);
  }

  // Future getAdsDetailData({required String docId}) async {
  //   Get.context?.loaderOverlay.show();
  //   AdminAdsListDataModel? getAdsData = (await DatabaseHelper.instance
  //       .getAdDataByDocId(docId: docId)) as AdminAdsListDataModel?;
  //   String userId = await getUid();
  //   preFilledAdDetailData.value = await DatabaseHelper.instance
  //       .getAdminSubmittedAd(uId: userId, adId: getAdsData?.docId ?? '');
  //   if (preFilledAdDetailData.value != null) {
  //     commentsController.text = preFilledAdDetailData.value?.comments ?? '';
  //   }
  //   adsDetailData.value = getAdsData;
  //   // getTotalSubmittedAdsCount(adId: getAdsData.docId);
  //   Get.context?.loaderOverlay.hide();
  // }

  Future getTotalSubmittedAdsCount({required String adId}) async {
    int count = await DatabaseHelper.instance
        .getTotalSubmittedAdsCountLast24Hours(adId: adId);
    totalSubmittedAdsCount.value = count;
  }

  Future<String?> storeUserSubmittedAds(
      {required AdminSubmitAdDataModel userSubmitAdDataModel}) async {
    Get.context?.loaderOverlay.show();

    /// store and get images in firebase storage
    List<String>? imageUrls = await DatabaseHelper.instance
        .storeUserSubmittedAdImages(
            adId: userSubmitAdDataModel.adId,
            uid: userSubmitAdDataModel.uId,
            filesList: pickedFiles);
    AdminSubmitAdDataModel updatedModel = AdminSubmitAdDataModel(
      adId: userSubmitAdDataModel.adId,
      uId: userSubmitAdDataModel.uId,
      addedDate: userSubmitAdDataModel.addedDate,
      comments: userSubmitAdDataModel.comments,
      imageList: imageUrls,
      status: userSubmitAdDataModel.status,
      adName: userSubmitAdDataModel.adName,
      company: userSubmitAdDataModel.company,
      adPrice: userSubmitAdDataModel.adPrice,
    );

    /// store submitted ad in database
    String?
        documentId = /*await DatabaseHelper.instance
        .storeUserSubmittedAds(userSubmitAdDataModel: updatedModel)*/
        '';
    Get.context?.loaderOverlay.hide();
    return documentId;
  }
}
