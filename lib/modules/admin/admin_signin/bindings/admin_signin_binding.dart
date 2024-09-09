import 'package:get/get.dart';

import '../admin_signin_controller.dart';

class AdminSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminSignInController.new);
  }
}
