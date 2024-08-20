import 'package:get/get.dart';
import '../user_signup_controller.dart';

class UserSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserSignUpController.new);
  }
}
