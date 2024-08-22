import 'package:get/get.dart';

import '../admin_drawer_controller.dart';

class AdminDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminDrawerMenuController.new);
  }
}
