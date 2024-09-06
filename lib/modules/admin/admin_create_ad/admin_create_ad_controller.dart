import 'package:RatingRadar_app/modules/user/user_homepage/model/user_ads_list_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';

class AdminCreateAdController extends GetxController {
  TextEditingController adNameController = TextEditingController();
  TextEditingController byCompanyNameController = TextEditingController();
  TextEditingController adPriceController = TextEditingController();
  TextEditingController adContentController = TextEditingController();
  TextEditingController adManagerIdController = TextEditingController();
  TextEditingController adLocationController = TextEditingController();

  Rx<UserAdsListDataModel?> adsDetailData = (null as UserAdsListDataModel?).obs;
  Rx<UserAdsListDataModel?> preFilledAdDetailData =
      (null as UserAdsListDataModel?).obs;
  RxList<XFile> pickedFiles = <XFile>[].obs;

  RxInt currentImageIndex = 0.obs;
  RxInt totalSubmittedAdsCount = 0.obs;

  Future<String> getAdminUid() async {
    return await PreferencesManager.getAdminId() ?? '';
  }

  Future removeImage(int index) async {
    pickedFiles.removeAt(index);
  }

  Future getTotalSubmittedAdsCount({required String adId}) async {
    int count = await DatabaseHelper.instance
        .getTotalSubmittedAdsCountLast24Hours(adId: adId);
    totalSubmittedAdsCount.value = count;
  }

  Future<String?> storeAdminSubmittedAds(
      {required UserAdsListDataModel adminSubmitAdDataModel}) async {
    Get.context?.loaderOverlay.show();
    String adminId = await getAdminUid();

    /// store and get images in firebase storage
    List<String>? imageUrls = await DatabaseHelper.instance
        .storeAdminCreatedAdsImages(adminId: adminId, filesList: pickedFiles);

    UserAdsListDataModel adAdsDataModel = UserAdsListDataModel(
      docId: adminSubmitAdDataModel.docId,
      adName: adminSubmitAdDataModel.adName,
      byCompany: adminSubmitAdDataModel.byCompany,
      imageUrl: imageUrls,
      adContent: adminSubmitAdDataModel.adContent,
      adPrice: adminSubmitAdDataModel.adPrice,
      addedDate: adminSubmitAdDataModel.addedDate,
      adStatus: adminSubmitAdDataModel.adStatus,
    );
    print("avni : ${adAdsDataModel.adPrice}");

    /// store submitted ad in database
    String? documentId = await DatabaseHelper.instance
        .storeAdminCreatedAds(userAdsListDataModel: adAdsDataModel);
    Get.context?.loaderOverlay.hide();
    return documentId;
  }

  void nextImage() {
    if (currentImageIndex.value < pickedFiles.length - 1) {
      currentImageIndex.value++;
    }
  }

  void previousImage() {
    if (currentImageIndex.value > 0) {
      currentImageIndex.value--;
    }
  }

  // Method to pick images
  Future pickImages() async {
    List<XFile> files = await ImagePicker().pickMultiImage(
      limit: 4,
    );
    if (files.length > 4) {
      files.removeRange(4, files.length);
    }
    if (pickedFiles.length < 4) {
      for (var file in files) {
        pickedFiles.add(file);
      }
    }
    pickedFiles.refresh();
  }

  void clearControllers() {
    adNameController.clear();
    byCompanyNameController.clear();
    adPriceController.clear();
    adLocationController.clear();
    adManagerIdController.clear();
    adContentController.clear();
    pickedFiles.clear();
  }
}
