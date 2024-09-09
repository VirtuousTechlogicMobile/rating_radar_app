import 'package:RatingRadar_app/modules/admin/admin_view_ad/admin_view_ad_controller.dart';
import 'package:get/get.dart';

class AdminViewAdBinding extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(AdminViewAdController.new);
  }
}
