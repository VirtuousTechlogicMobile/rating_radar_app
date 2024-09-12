import 'package:get/get.dart';

import '../admin_all_user_controller.dart';

class AdminAllUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AdminAllUserController.new);
  }
}
