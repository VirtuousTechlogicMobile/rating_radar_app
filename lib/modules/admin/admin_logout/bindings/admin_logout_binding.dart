import 'package:get/get.dart';

import '../admin_logout_controller.dart';

class AdminLogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminLogoutController.new);
  }
}
