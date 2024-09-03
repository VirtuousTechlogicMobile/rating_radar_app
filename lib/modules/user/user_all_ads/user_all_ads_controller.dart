import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../user_homepage/model/user_ads_list_data_model.dart';

class UserAllAdsController extends GetxController {
  RxBool isShowLoader = false.obs;
  RxList<UserAdsListDataModel> adsList = <UserAdsListDataModel>[].obs;
  ScrollController scrollController = ScrollController();
  RxInt totalAdsCount = 0.obs;

  Future getAdsList({UserAdsListDataModel? adLastDocument}) async {
    Get.context?.loaderOverlay.show();
    totalAdsCount.value = await DatabaseHelper.instance.getTotalAdsCount();
    List<UserAdsListDataModel>? getAllAdsList = await DatabaseHelper.instance.getAllAdsList(nDataPerPage: 10, adLastDocument: adLastDocument);
    if (getAllAdsList != null) {
      for (var ads in getAllAdsList) {
        adsList.add(ads);
      }
    }
    Get.context?.loaderOverlay.hide();
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && adsList.length != totalAdsCount.value) {
      getAdsList(adLastDocument: adsList.last);
    }
  }
}
