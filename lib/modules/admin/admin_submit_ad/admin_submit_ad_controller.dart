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
  TextEditingController adNameController = TextEditingController();
  TextEditingController byCompanyNameController = TextEditingController();
  TextEditingController adPriceController = TextEditingController();
  TextEditingController adContentController = TextEditingController();
  TextEditingController adManagerIdController = TextEditingController();
  TextEditingController adLocationController = TextEditingController();

  RxInt currentImageIndex = 0.obs;
  RxInt totalSubmittedAdsCount = 0.obs;
  Future<String> getUid() async {
    return await PreferencesManager.getUserId() ?? '';
  }

/*
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
*/

  Future removeImage(int index) async {
    pickedFiles.removeAt(index);
  }

  /*Future getAdsDetailData() async {
    Get.context?.loaderOverlay.show();
     */ /* UserAdsListDataModel? getAdsData =
        (await DatabaseHelper.instance.getAdDataByDocId(docId: docId)); */ /*
    // String userId = await getUid();
    preFilledAdDetailData.value = (await DatabaseHelper.instance
        .getAllAdminSubmittedAds()) as AdminSubmitAdDataModel?;
    if (preFilledAdDetailData.value != null) {
      commentsController.text = preFilledAdDetailData.value?.comments ?? '';
    }
    adsDetailData.value = getAdsData;
    // getTotalSubmittedAdsCount(adId: getAdsData.docId);
    Get.context?.loaderOverlay.hide();
  }
*/
  Future getTotalSubmittedAdsCount({required String adId}) async {
    int count = await DatabaseHelper.instance
        .getTotalSubmittedAdsCountLast24Hours(adId: adId);
    totalSubmittedAdsCount.value = count;
  }

  Future<String?> storeUserSubmittedAds(
      {required AdminSubmitAdDataModel adminSubmitAdDataModel}) async {
    Get.context?.loaderOverlay.show();

    /// store and get images in firebase storage
    List<String>? imageUrls = await DatabaseHelper.instance
        .storeUserSubmittedAdImages(
            adId: adminSubmitAdDataModel.adId,
            uid: adminSubmitAdDataModel.uId,
            filesList: pickedFiles);
    AdminSubmitAdDataModel updatedModel = AdminSubmitAdDataModel(
      adId: adminSubmitAdDataModel.adId,
      uId: adminSubmitAdDataModel.uId,
      addedDate: adminSubmitAdDataModel.addedDate,
      comments: adminSubmitAdDataModel.comments,
      imageList: imageUrls,
      status: adminSubmitAdDataModel.status,
      adName: adminSubmitAdDataModel.adName,
      company: adminSubmitAdDataModel.company,
      adPrice: adminSubmitAdDataModel.adPrice,
    );

    /// store submitted ad in database
    String? documentId = await DatabaseHelper.instance
        .storeAdminSubmittedAds(adminSubmitAdDataModel: updatedModel);
    Get.context?.loaderOverlay.hide();
    return documentId;
  }

  void nextImage() {
    if (adsDetailData.value?.imageUrl != null &&
        currentImageIndex.value < (adsDetailData.value!.imageUrl!.length - 1)) {
      currentImageIndex.value++;
    }
  }

  void previousImage() {
    if (adsDetailData.value?.imageUrl != null && currentImageIndex.value > 0) {
      currentImageIndex.value--;
    }
  }

  // Method to pick images
  Future<void> pickImages() async {
    final picked = await ImagePicker().pickMultiImage(); // Pick multiple images
    if (picked != null) {
      pickedFiles.addAll(picked);
    }
  }
}
