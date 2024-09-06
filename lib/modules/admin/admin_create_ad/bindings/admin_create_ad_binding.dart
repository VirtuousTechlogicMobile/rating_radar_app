import 'package:get/get.dart';

import '../admin_create_ad_controller.dart';

class AdminCreateAdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminCreateAdController.new);
  }
}
