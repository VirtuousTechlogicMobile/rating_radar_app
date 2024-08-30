import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/database_helper/database_helper.dart';

class UserLogoutController extends GetxController {
  Future logoutUser() async {
    Get.context?.loaderOverlay.show();
    await DatabaseHelper.instance.logoutUser();
    Get.context?.loaderOverlay.hide();
  }
}
