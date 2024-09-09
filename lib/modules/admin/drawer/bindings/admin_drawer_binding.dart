import 'package:get/get.dart';

import '../admin_drawer_controller.dart';

class AdminDrawerBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AdminDrawerMenuController>()) {
      Get.put(AdminDrawerMenuController(), permanent: true);
    }
  }
}
