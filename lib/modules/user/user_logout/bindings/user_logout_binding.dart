import 'package:get/get.dart';
import '../user_logout_controller.dart';

class UserLogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserLogoutController.new);
  }
}
