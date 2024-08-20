import 'package:get/get.dart';

import '../custom_signin_tabbar_controller.dart';

class CustomSignInTabBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CustomSignInTabBarController.new);
  }
}
