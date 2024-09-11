import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'model/user_signup_model.dart';

class UserSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isShowConfirmPassword = false.obs;
  RxBool isShowLoadingOnButton = false.obs;

  Future<String> signUpUser({required UserDataModel userSignupModel}) async {
    isShowLoadingOnButton.value = true;
    return await DatabaseHelper.instance
        .signUpUser(
      userSignupModel: userSignupModel,
    )
        .then(
      (value) async {
        isShowLoadingOnButton.value = false;
        return value;
      },
    );
  }

  void clearControllers() {
    emailController.clear();
    userNameController.clear();
    contactNumberController.clear();
    passwordController1.clear();
    passwordController2.clear();
  }
}
