import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'model/admin_signin_model.dart';

class AdminSignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isShowLoadingOnButton = false.obs;

  Future signInAdmin({required String email, required String password}) async {
    isShowLoadingOnButton.value = true;
    return await DatabaseHelper.instance
        .signInAdmin(
            adminSignInModel:
                AdminSignInModel(email: email, password: password))
        .then(
      (value) async {
        isShowLoadingOnButton.value = false;
        return value;
      },
    );
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
