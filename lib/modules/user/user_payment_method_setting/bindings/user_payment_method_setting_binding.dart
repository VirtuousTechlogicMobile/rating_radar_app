import 'package:RatingRadar_app/modules/user/user_payment_method_setting/user_payment_method_setting_controller.dart';
import 'package:get/get.dart';

class UserPaymentMethodSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserPaymentMethodSettingController.new);
  }
}
