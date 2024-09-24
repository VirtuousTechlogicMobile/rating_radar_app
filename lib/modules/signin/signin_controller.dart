import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../helper/database_helper/database_helper.dart';
import 'model/signin_model.dart';

class UserSignInController extends GetxController {
  TextEditingController emailOrUserNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isShowLoadingOnButton = false.obs;
  RxInt selectedRole = 1.obs;

  Future<String> signInUser({required String email, required String password}) async {
    isShowLoadingOnButton.value = true;
    return await DatabaseHelper.instance.signInUser(userSignInModel: UserSignInModel(email: email, password: password)).then(
      (value) async {
        isShowLoadingOnButton.value = false;
        return value;
      },
    );
  }

  Future signInManager({required String email, required String password}) async {
    isShowLoadingOnButton.value = true;
    return await DatabaseHelper.instance.signInManager(userSignInModel: UserSignInModel(email: email, password: password)).then(
      (value) async {
        isShowLoadingOnButton.value = false;
        return value;
      },
    );
  }

  /// Firebase Query


  void clearControllers() {
    emailOrUserNameController.clear();
    passwordController.clear();
  }
}
