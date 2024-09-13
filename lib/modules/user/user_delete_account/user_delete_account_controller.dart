import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../constant/strings.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../utility/utility.dart';

class UserDeleteAccountController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxBool isShowPassword = false.obs;

  Future deleteUser() async {
    Get.context?.loaderOverlay.show();
    String? updateStatus = await DatabaseHelper.instance.deleteUserUsingPassword(userPassword: passwordController.text);
    if (updateStatus == CustomStatus.success) {
      RouteManagement.goToUserSignUpScreen();
      AppUtility.showSnackBar('your_account_deleted_successfully'.tr);
    } else if (updateStatus == CustomStatus.wrongEmailPassword) {
      AppUtility.showSnackBar('wrong_password'.tr);
    } else if (updateStatus == CustomStatus.requiresRecentLogin) {
      AppUtility.showSnackBar('for_security_reasons_you_need_to_log_in_again_before_delete_account'.tr);
    } else {
      AppUtility.showSnackBar('failed_to_delete_account'.tr);
    }
    Get.context?.loaderOverlay.hide();
  }
}
