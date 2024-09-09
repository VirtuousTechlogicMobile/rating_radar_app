import 'package:get/get.dart';

import '../admin_header_controller.dart';

class AdminHeaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminHeaderController.new);
  }
}
