import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';

class AdminLogoutController extends GetxController {
  Future logoutAdmin() async {
    Get.context?.loaderOverlay.show();
    await DatabaseHelper.instance.logoutAdmin();
    Get.context?.loaderOverlay.hide();
  }
}
