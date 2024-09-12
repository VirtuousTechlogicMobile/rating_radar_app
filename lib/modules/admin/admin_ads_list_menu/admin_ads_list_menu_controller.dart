import 'package:RatingRadar_app/modules/user/user_homepage/model/user_ads_list_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/date_time_formatter.dart';

class AdminAdsListMenuController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  RxList<UserAdsListDataModel> adminCreatedAdsList = <UserAdsListDataModel>[].obs;
  RxInt selectedPage = 1.obs;
  RxInt totalAdminSubmittedAds = 0.obs;
  RxList<RxBool> isHoveredList = <RxBool>[].obs;

  Future getAdsData({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    List<UserAdsListDataModel>? submittedAdData = await DatabaseHelper.instance.getsAdminTotalAdsList(
      nDataPerPage: 9,
      pageNumber: selectedPage.value,
      sortBy: sortBy,
      searchTerm: searchTerm,
    );
    if (submittedAdData != null) {
      adminCreatedAdsList.value = submittedAdData;
      isHoveredList.value = List.generate(submittedAdData.length, (_) => false.obs);
    }
    adminCreatedAdsList.refresh();
    Get.context?.loaderOverlay.hide();
  }

  Future getAdsCount() async {
    totalAdminSubmittedAds.value = await DatabaseHelper.instance.getsAdminSubmittedAdsListCount();
  }

  // Safe parsing method to handle null and type issues
  String parseDate(dynamic dateTime) {
    if (dateTime is DateTime) {
      return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
    } else if (dateTime is Timestamp) {
      // If it's a Firestore Timestamp, convert to DateTime first
      return DateTimeFormatter.formatTimeStampToDashedDate(dateTime.toDate());
    } else {
      // Handle the case where the dateTime is null or another type
      return 'Invalid date';
    }
  }
}
