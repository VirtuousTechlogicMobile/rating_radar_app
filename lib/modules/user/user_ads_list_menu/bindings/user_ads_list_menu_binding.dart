import 'package:RatingRadar_app/modules/user/user_ads_list_menu/user_ads_list_menu_controller.dart';
import 'package:get/get.dart';

class UserAdsListMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserAdsListMenuController.new);
  }
}
