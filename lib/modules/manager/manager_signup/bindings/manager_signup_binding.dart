import 'package:get/get.dart';
import '../manager_signup_controller.dart';

class ManagerSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ManagerSignUpController.new);
  }
}
