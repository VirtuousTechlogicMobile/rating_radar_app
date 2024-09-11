import 'package:RatingRadar_app/modules/user/user_delete_account/user_delete_account_controller.dart';
import 'package:get/get.dart';

class UserDeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(UserDeleteAccountController.new);
  }
}
