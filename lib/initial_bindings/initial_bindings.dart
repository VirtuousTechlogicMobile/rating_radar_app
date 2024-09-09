import 'package:RatingRadar_app/modules/user/drawer/drawer_controller.dart';
import 'package:RatingRadar_app/modules/user/header/header_controller.dart';
import 'package:get/get.dart';

import '../modules/user/user_settings_menu_drawer/user_settings_menu_drawer_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DrawerMenuController());
    Get.put(HeaderController());
    Get.put(UserSettingsMenuDrawerController());
  }
}
