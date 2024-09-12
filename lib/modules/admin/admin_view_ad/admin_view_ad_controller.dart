import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../constant/strings.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../../user/user_homepage/model/user_ads_list_data_model.dart';
import 'admin_ad_comments_data.dart';

class AdminViewAdController extends GetxController {
  Rx<UserAdsListDataModel?> adsDetailData = (null as UserAdsListDataModel?).obs;
  Rx<UserAdsListDataModel?> preFilledAdDetailData = (null as UserAdsListDataModel?).obs;
  RxList<XFile> pickedFiles = <XFile>[].obs;
  RxList<AdminCommentsListUserData> getUserCommentedDataList = <AdminCommentsListUserData>[].obs;
  TextEditingController commentsController = TextEditingController();
  TextEditingController blocActionReasonController = TextEditingController();
  RxList<AdminCommentsListUserData> userCommentedList = <AdminCommentsListUserData>[].obs;

  RxInt selectedActionIndex = 0.obs;
  RxInt selectedStatusIndex = 0.obs;

  RxInt currentImageIndex = 0.obs;
  RxInt totalSubmittedAdsCount = 0.obs;

  Future<String> getUid() async {
    return await PreferencesManager.getUserId() ?? '';
  }

  Future<String> getAdminUid() async {
    return await PreferencesManager.getAdminId() ?? '';
  }

  List<String> adminStatusList = [
    CustomStatus.active,
    CustomStatus.pause,
    CustomStatus.finished,
  ];
  List<String> adminActionsList = [
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
    UserAdsListDataModel? getAdsData = await DatabaseHelper.instance.getAdDataByDocId(docId: docId);

    preFilledAdDetailData.value = await DatabaseHelper.instance.getAdminSubmittedAdDetailData(adId: docId);

    adsDetailData.value = getAdsData;
    selectedStatusIndex.value = getStatusConvertIndex(adsDetailData.value?.adStatus ?? '');
    selectedActionIndex.value = getActionConvertIndex(adsDetailData.value?.companyAdAction ?? '');

    Get.context?.loaderOverlay.hide();
  }

  Future getTotalSubmittedAdsCount({required String adId}) async {
    int count = await DatabaseHelper.instance.getTotalSubmittedAdsCountLast24Hours(adId: adId);
    totalSubmittedAdsCount.value = count;
  }

  Future<String?> updateAdminCustomStatusAds({
    required String status,
    required String action,
    required String adId,
    String? reason,
  }) async {
    try {
      Get.context?.loaderOverlay.show();

      String? documentId = await DatabaseHelper.instance.updateAdCustomStatus(status: status, adId: adId, action: action, reason: reason);
      Get.context?.loaderOverlay.hide();
      if (documentId == CustomStatus.success) {
        getAdsDetailData(docId: adId);
      }
      return documentId;
    } catch (e) {
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

    List<AdminCommentsListUserData>? getUserCommentedDataList = await DatabaseHelper.instance.getCommentedUsersData(adId: adId);

    if (getUserCommentedDataList != null) {
      print("Fetched Comments: ${getUserCommentedDataList.length}");
      userCommentedList.value = getUserCommentedDataList;
    } else {
      print("No comments fetched");
    }

    Get.context?.loaderOverlay.hide();
  }

  String getActionIndex(int index) {
    switch (index) {
      case 0:
        return CustomStatus.approved;
      case 1:
        return CustomStatus.pending;
      case 2:
        return CustomStatus.rejected;
      case 3:
        return CustomStatus.blocked;
      default:
        return CustomStatus.approved;
    }
  }

  String getStatusIndex(int index) {
    switch (index) {
      case 0:
        return CustomStatus.active;
      case 1:
        return CustomStatus.pause;
      case 2:
        return CustomStatus.finished;
      default:
        return CustomStatus.active;
    }
  }

  int getStatusConvertIndex(String status) {
    switch (status) {
      case CustomStatus.active:
        return 0;
      case CustomStatus.pause:
        return 1;
      case CustomStatus.finished:
        return 2;
      default:
        return 0;
    }
  }

  int getActionConvertIndex(String status) {
    switch (status) {
      case CustomStatus.approved:
        return 0;
      case CustomStatus.pending:
        return 1;
      case CustomStatus.rejected:
        return 2;
      case CustomStatus.blocked:
        return 3;
      default:
        return 0;
    }
  }

  bool shouldDisplayOption(int index, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return index == 0 || index == 3; // Show only index 0 and 3 (Approve and Block)
      case 1:
        return index == 0 || index == 2;
      case 2:
        return index == 2;
      case 3:
        return index == 0 || index == 3; // Show only index 0 and 2 (Approve and Reject)
      default:
        return true; // For other values, display all options
    }
  }

  void clearControllers() {
    blocActionReasonController.clear();
  }
}
