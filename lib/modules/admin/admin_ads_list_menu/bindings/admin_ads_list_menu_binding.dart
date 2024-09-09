import 'package:get/get.dart';

import '../admin_ads_list_menu_controller.dart';

class AdminAdsListMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminAdsListMenuController.new);
  }
}
