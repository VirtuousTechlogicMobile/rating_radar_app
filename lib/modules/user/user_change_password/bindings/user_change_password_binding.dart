import 'package:get/get.dart';

import '../user_change_password_controller.dart';

class UserChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(UserChangePasswordController.new);
  }
}
