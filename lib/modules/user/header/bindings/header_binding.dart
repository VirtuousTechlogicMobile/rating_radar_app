import 'package:RatingRadar_app/modules/user/header/header_controller.dart';
import 'package:get/get.dart';

class HeaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HeaderController.new);
  }
}
