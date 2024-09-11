import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../constant/strings.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../../user/user_homepage/model/user_ads_list_data_model.dart';
import '../../user/user_submit_ad/model/user_submit_ad_data_model.dart';
import 'admin_ad_comments_data.dart';

class AdminViewAdController extends GetxController {
  Rx<UserAdsListDataModel?> adsDetailData = (null as UserAdsListDataModel?).obs;
  Rx<UserSubmitAdDataModel?> preFilledAdDetailData =
      (null as UserSubmitAdDataModel?).obs;
  RxList<XFile> pickedFiles = <XFile>[].obs;
  RxList<AdminCommentsListUserData> getUserCommentedDataList =
      <AdminCommentsListUserData>[].obs;
  TextEditingController commentsController = TextEditingController();
  RxList<AdminCommentsListUserData> userCommentedList =
      <AdminCommentsListUserData>[].obs;

  RxInt currentImageIndex = 0.obs;
  RxInt totalSubmittedAdsCount = 0.obs;

  Future<String> getUid() async {
    return await PreferencesManager.getUserId() ?? '';
  }

  Future<String> getAdminUid() async {
    return await PreferencesManager.getAdminId() ?? '';
  }

  ValueNotifier<String> selectedAdStatus =
      ValueNotifier<String>(CustomStatus.active);

  void setAdStatus(String status) {
    selectedAdStatus.value = status;
  }

  List<String> adminCustomStatus = [
    CustomStatus.active,
    CustomStatus.play,
    CustomStatus.pause,
    CustomStatus.finished,
  ];
  List<String> adminCustomAction = [
    CustomStatus.approved,
    CustomStatus.pending,
    CustomStatus.rejected,
    CustomStatus.blocked,
  ];
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
    UserAdsListDataModel? getAdsData =
        await DatabaseHelper.instance.getAdDataByDocId(docId: docId);
    String userId = await getUid();
    preFilledAdDetailData.value = await DatabaseHelper.instance
        .getUserSubmittedAdDetailData(adId: docId, uId: userId);
    if (preFilledAdDetailData.value != null) {
      commentsController.text = preFilledAdDetailData.value?.comments ?? '';
    }
    adsDetailData.value = getAdsData;
    Get.context?.loaderOverlay.hide();
  }

  Future getTotalSubmittedAdsCount({required String adId}) async {
    int count = await DatabaseHelper.instance
        .getTotalSubmittedAdsCountLast24Hours(adId: adId);
    totalSubmittedAdsCount.value = count;
  }

  Future<String?> updateAdminCustomStatusAds({
    required String status,
    required String adId,
  }) async {
    try {
      // Show loader before starting the update
      Get.context?.loaderOverlay.show();

      // Call the database helper method to update the status
      String? documentId = await DatabaseHelper.instance
          .updateAdCustomStatus(status: status, adId: adId);

      // Hide loader after the operation is done
      Get.context?.loaderOverlay.hide();

      // Log and check the result
      if (documentId == CustomStatus.success) {
        print("Status updated successfully: Status = $status, Ad ID = $adId");
      } else {
        print("Failed to update status for Ad ID = $adId");
      }

      // Return the document ID or success status
      return documentId;
    } catch (e) {
      // Hide the loader in case of an exception
      Get.context?.loaderOverlay.hide();

      // Log the exception
      print("Error updating status: $e");
      return null;
    }
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

  Future<void> getUserList({required String adId}) async {
    Get.context?.loaderOverlay.show();

    List<AdminCommentsListUserData>? getUserCommentedDataList =
        await DatabaseHelper.instance.getCommentedUsersData(adId: adId);

    if (getUserCommentedDataList != null) {
      print("Fetched Comments: ${getUserCommentedDataList.length}");
      userCommentedList.value = getUserCommentedDataList;
    } else {
      print("No comments fetched");
    }

    Get.context?.loaderOverlay.hide();
  }
}
