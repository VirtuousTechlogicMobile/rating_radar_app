import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/date_time_formatter.dart';
import 'model/user_submitted_ads_list_data_model.dart';

class UserAdsListMenuController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  RxList<UserSubmittedAdsListDataModel> userSubmittedAdsList = <UserSubmittedAdsListDataModel>[].obs;

  Future getAdsData() async {
    Get.context?.loaderOverlay.show();
    List<UserSubmittedAdsListDataModel>? submittedAdData = await DatabaseHelper.instance.getsUserSubmittedAdsList(nDataPerPage: 9);
    if (submittedAdData != null) {
      for (UserSubmittedAdsListDataModel ads in submittedAdData) {
        userSubmittedAdsList.add(ads);
      }
    }
    Get.context?.loaderOverlay.hide();
  }

  String parseDate(DateTime dateTime) {
    return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
  }
}
