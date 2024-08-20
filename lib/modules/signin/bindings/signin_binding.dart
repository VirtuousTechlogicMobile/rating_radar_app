import 'package:get/get.dart';
import '../signin_controller.dart';

class UserSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserSignInController.new);
  }
}
