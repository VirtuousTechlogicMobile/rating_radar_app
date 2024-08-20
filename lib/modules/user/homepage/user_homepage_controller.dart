import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:RatingRadar_app/helper/shared_preferences_manager/preferences_manager.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'model/user_ads_list_data_model.dart';

class UserHomepageController extends GetxController {
  Future<String?> getUserUid() async {
    return await PreferencesManager.getUserId();
  }

  List<String> dropdownItemsList = ['today'.tr, 'lastWeek'.tr, 'lastMonth'.tr, 'lastYear'.tr, 'allTime'.tr];
  RxInt selectedDropDownItemIndex = 0.obs;

  RxList<bool> isViewComponentHoveredList = List.generate(1, (index) => false).obs;

  Rxn<List<UserAdsListDataModel>> adsList = Rxn<List<UserAdsListDataModel>>();

  Future getAdsList() async {
    Get.context?.loaderOverlay.show();
    List<UserAdsListDataModel>? getAdsList = await DatabaseHelper.instance.getLimitedAdsList(limit: 6);
    adsList.value = getAdsList;
    Get.context?.loaderOverlay.hide();
  }
}
