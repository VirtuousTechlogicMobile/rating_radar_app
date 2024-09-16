import 'package:RatingRadar_app/modules/admin/admin_manager/admin_manager_controller.dart';
import 'package:get/get.dart';

class AdminManagerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    return Get.lazyPut(AdminManagerController.new);
  }
}
