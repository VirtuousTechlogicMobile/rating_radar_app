import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/date_time_formatter.dart';
import 'model/admin_submitted_ads_list_data_model.dart';

class AdminAdsListMenuController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  RxList<AdminSubmittedAdsListDataModel> adminSubmittedAdsList =
      <AdminSubmittedAdsListDataModel>[].obs;

  Future getAdsData() async {
    Get.context?.loaderOverlay.show();
    List<AdminSubmittedAdsListDataModel>? submittedAdData = await DatabaseHelper
        .instance
        .getsAdminSubmittedAdsList(nDataPerPage: 9);
    if (submittedAdData != null) {
      for (AdminSubmittedAdsListDataModel ads in submittedAdData) {
        adminSubmittedAdsList.add(ads);
      }
    }
    Get.context?.loaderOverlay.hide();
  }

  String parseDate(DateTime dateTime) {
    return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
  }
}
