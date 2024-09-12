import 'package:RatingRadar_app/modules/user/user_referral/user_referral_controller.dart';
import 'package:get/get.dart';

class UserReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserReferralController.new);
  }
}
