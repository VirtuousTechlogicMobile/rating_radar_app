import 'package:RatingRadar_app/modules/user/user_wallet/user_wallet_controller.dart';
import 'package:get/get.dart';

class UserWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserWalletController.new, fenix: false);
  }
}
