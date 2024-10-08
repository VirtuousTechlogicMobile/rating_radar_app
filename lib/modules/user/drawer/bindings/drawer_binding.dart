import 'package:get/get.dart';
import '../drawer_controller.dart';

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DrawerMenuController.new);
  }
}
