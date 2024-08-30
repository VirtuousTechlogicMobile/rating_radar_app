import 'package:get/get.dart';

import '../admin_all_ads_controller.dart';

class AdminAllAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminAllAdsController.new);
  }
}
