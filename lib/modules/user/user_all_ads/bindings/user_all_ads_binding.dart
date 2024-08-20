import 'package:RatingRadar_app/modules/user/user_all_ads/user_all_ads_controller.dart';
import 'package:get/get.dart';

class UserAllAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserAllAdsController.new);
  }
}
