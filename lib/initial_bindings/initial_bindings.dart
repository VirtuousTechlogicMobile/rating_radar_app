import 'package:RatingRadar_app/modules/admin/drawer/admin_drawer_controller.dart';
import 'package:RatingRadar_app/modules/user/drawer/drawer_controller.dart';
import 'package:RatingRadar_app/modules/user/header/header_controller.dart';
import 'package:get/get.dart';

import '../modules/admin/admin_header/admin_header_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DrawerMenuController());
    Get.put(HeaderController());
    Get.put(AdminHeaderController());
    Get.put(AdminDrawerMenuController());
  }
}
