import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'model/manager_signup_model.dart';

class ManagerSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController managerIdController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isShowConfirmPassword = false.obs;
  RxBool isShowLoadingOnButton = false.obs;

  Future<bool> checkManagerExists({required String email}) async {
    return await DatabaseHelper.instance.checkManagerExists(email: email);
  }

  Future<String> signUpManager({required String email, required String userName, required String phoneNumber, required String managerId, required String password}) async {
    isShowLoadingOnButton.value = true;
    return await DatabaseHelper.instance
        .signUpManager(
      managerSignupModel: ManagerSignupModel(
        email: email,
        username: userName,
        phoneNumber: phoneNumber,
        managerId: managerId,
        password: password,
      ),
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
    managerIdController.clear();
    passwordController1.clear();
    passwordController2.clear();
  }
}
