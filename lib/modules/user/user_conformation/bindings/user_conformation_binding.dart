import 'package:get/get.dart';

import '../user_conformation_controller.dart';

class UserConformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(UserConformationController.new);
  }
}
