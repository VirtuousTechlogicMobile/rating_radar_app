import 'package:get/get.dart';
import '../user_homepage_controller.dart';

class UserHomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserHomepageController.new);
  }
}
