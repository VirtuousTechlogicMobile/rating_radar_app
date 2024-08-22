import 'package:get/get.dart';

import '../admin_homepage_controller.dart';

class AdminHomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminHomepageController.new);
  }
}
