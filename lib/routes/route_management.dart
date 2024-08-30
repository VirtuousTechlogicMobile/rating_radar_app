import 'package:get/get.dart';
import '../modules/user/user_signup/model/user_signup_model.dart';
import 'app_pages.dart';

abstract class RouteManagement {
  /// user module --------------------------------------------------------------------------

  static void goToUserSignUpView() {
    Get.toNamed(AppRoutes.signUp);
  }

  static void goToUserSignInView() {
    Get.offAllNamed(AppRoutes.signIn);
  }

  static void goToUserConformationView({required String email}) {
    Get.toNamed(AppRoutes.emailConformation, parameters: {'email': email});
  }

  static void goToUserHomePageView() {
    Get.offAllNamed(AppRoutes.userHomePage);
  }

  static void goToUserAllAdsListScreenView() {
    Get.toNamed(AppRoutes.userAllAds);
  }

  static void goToUserSubmitAdScreenView({required String adDocumentId}) {
    Get.toNamed(AppRoutes.userSubmitAd, parameters: {'adDocumentId': adDocumentId});
  }

  static void goToUserAdsListMenuView() {
    Get.toNamed(AppRoutes.userAdsList);
  }

  static void goToLogoutView() {
    Get.toNamed(AppRoutes.userLogout);
  }

  /// manager module --------------------------------------------------------------------------

  static void goToManagerSignUpView() {
    Get.toNamed(AppRoutes.managerSignUp);
  }

  /// admin module --------------------------------------------------------------------------

  /// Go to back Page / Close Pages --------------------------------------------

  static void goToBack() {
    Get.back();
  }
}
