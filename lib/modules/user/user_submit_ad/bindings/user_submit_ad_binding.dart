import 'package:RatingRadar_app/modules/user/user_submit_ad/user_submit_ad_controller.dart';
import 'package:get/get.dart';

class UserSubmitAdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserSubmitAdController.new);
  }
}
