import 'dart:developer';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../homepage/model/user_ads_list_data_model.dart';
import 'model/user_submit_ad_data_model.dart';

class UserSubmitAdController extends GetxController {
  Rx<UserAdsListDataModel?> adsDetailData = (null as UserAdsListDataModel?).obs;
  RxList<XFile> pickedFiles = <XFile>[].obs;
  TextEditingController commentsController = TextEditingController();

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

  Future getAdsDetailData({required String docId}) async {
    Get.context?.loaderOverlay.show();
    UserAdsListDataModel? getAdsList = await DatabaseHelper.instance.documentData(docId: docId);
    adsDetailData.value = getAdsList;
    Get.context?.loaderOverlay.hide();
  }

  Future<String?> storeUserSubmittedAds({required UserSubmitAdDataModel userSubmitAdDataModel}) async {
    Get.context?.loaderOverlay.show();

    /// store and get images in firebase storage
    List<String>? imageUrls = await DatabaseHelper.instance.storeUserSubmittedAdImages(adId: userSubmitAdDataModel.adId, uid: userSubmitAdDataModel.uId, filesList: pickedFiles);
    UserSubmitAdDataModel updatedModel = UserSubmitAdDataModel(
        adId: userSubmitAdDataModel.adId,
        uId: userSubmitAdDataModel.uId,
        addedDate: userSubmitAdDataModel.addedDate,
        comments: userSubmitAdDataModel.comments,
        imageList: imageUrls,
        status: userSubmitAdDataModel.status);

    /// store submitted ad in database
    String? documentId = await DatabaseHelper.instance.storeUserSubmittedAds(userSubmitAdDataModel: updatedModel);
    Get.context?.loaderOverlay.hide();
    return documentId;
  }
}
