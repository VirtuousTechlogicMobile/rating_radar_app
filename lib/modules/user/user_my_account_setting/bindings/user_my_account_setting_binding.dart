import 'package:get/get.dart';
import '../user_my_account_setting_controller.dart';

class UserMyAccountSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserMyAccountSettingController.new);
  }
}
