import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserChangePasswordController extends GetxController {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  RxBool isShowPassword1 = false.obs;
  RxBool isShowPassword2 = false.obs;

  Future changeUserPassword() async {
    Get.context?.loaderOverlay.show();
    String? updateStatus = await DatabaseHelper.instance.updateUserPassword(newPassword: passwordController1.text);
    if (updateStatus == CustomStatus.success) {
      AppUtility.showSnackBar('password_changed_successfully'.tr);
      passwordController1.clear();
      passwordController2.clear();
    } else if (updateStatus == CustomStatus.passwordExists) {
      AppUtility.showSnackBar('the_new_password_must_be_different_from_the_old_one'.tr);
    } else if (updateStatus == CustomStatus.requiresRecentLogin) {
      AppUtility.showSnackBar('for_security_reasons_you_need_to_log_in_again_before_changing_the_password'.tr);
    } else {
      AppUtility.showSnackBar('something_want_wrong'.tr);
    }
    Get.context?.loaderOverlay.hide();
  }
}
