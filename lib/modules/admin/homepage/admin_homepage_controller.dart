import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import 'model/admin_ads_list_data_model.dart';

class AdminHomepageController extends GetxController {
  Future<String?> getUserUid() async {
    return await PreferencesManager.getUserId();
  }

  List<String> adminDropdownItemList = [
    'today'.tr,
    'lastWeek'.tr,
    'lastMonth'.tr,
    'lastYear'.tr,
    'allTime'.tr
  ];
  RxInt selectedDropdownItemIndex = 0.obs;
  RxList<bool> isViewComponentHoveredList =
      List.generate(1, (index) => false).obs;

  Rxn<List<AdminAdsListDataModel>> adsList = Rxn<List<AdminAdsListDataModel>>();
  Future getAdsList() async {
    Get.context?.loaderOverlay.show();
    List<AdminAdsListDataModel>? getAdsList =
        await DatabaseHelper.instance.admingetLimitedAdsList(limit: 6);
    adsList.value = getAdsList;
    Get.context?.loaderOverlay.hide();
  }
}
