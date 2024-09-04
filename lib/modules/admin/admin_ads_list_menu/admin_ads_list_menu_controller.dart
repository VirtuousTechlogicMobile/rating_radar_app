import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/date_time_formatter.dart';
import '../homepage/model/admin_ads_list_data_model.dart';

class AdminAdsListMenuController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  RxList<AdminAdsListDataModel> adminSubmittedAdsList =
      <AdminAdsListDataModel>[].obs;
  RxInt selectedPage = 1.obs;
  RxInt totalAdminSubmittedAds = 0.obs;

  Future getAdsData({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();

    List<AdminAdsListDataModel>? submittedAdData =
        await DatabaseHelper.instance.getsAdminSubmittedAdsList(
      nDataPerPage: 9,
      pageNumber: selectedPage.value,
      sortBy: sortBy,
      searchTerm: searchTerm,
    );
    adminSubmittedAdsList.value = submittedAdData!;
    // print("object ${adminSubmittedAdsList.value}");
    Get.context?.loaderOverlay.hide();
  }

  Future getAdsCount() async {
    totalAdminSubmittedAds.value =
        await DatabaseHelper.instance.getsAdminSubmittedAdsListCount();
  }

  String parseDate(DateTime dateTime) {
    return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
  }
}
