import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/date_time_formatter.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import 'model/user_submitted_ads_list_data_model.dart';

class UserAdsListMenuController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  RxInt selectedPage = 1.obs;
  RxInt totalUserSubmittedAds = 0.obs;
  RxList<UserSubmittedAdsListDataModel> userSubmittedAdsList = <UserSubmittedAdsListDataModel>[].obs;

  Future getAdsData({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    String uId = await PreferencesManager.getUserId() ?? '';
    List<UserSubmittedAdsListDataModel>? submittedAdData = await DatabaseHelper.instance.getsUserSubmittedAdsList(
      uId: uId,
      nDataPerPage: 9,
      pageNumber: selectedPage.value,
      sortBy: sortBy,
      searchTerm: searchTerm,
    );
    if (submittedAdData != null) {
      userSubmittedAdsList.clear();
      for (UserSubmittedAdsListDataModel ads in submittedAdData) {
        userSubmittedAdsList.add(ads);
      }
    }
    userSubmittedAdsList.refresh();
    Get.context?.loaderOverlay.hide();
  }

  Future getAdsCount() async {
    totalUserSubmittedAds.value = await DatabaseHelper.instance.getsUserSubmittedAdsListCount();
  }

  String parseDate(DateTime dateTime) {
    return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
  }
}
