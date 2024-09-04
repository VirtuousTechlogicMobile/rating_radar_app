import 'package:get/get.dart';

import '../admin_submit_ad_controller.dart';

class AdminSubmitAdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminSubmitAdController.new);
  }
}
