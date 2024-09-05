import 'package:get/get.dart';

import 'app_pages.dart';

abstract class RouteManagement {
  /// user module --------------------------------------------------------------------------

  static void goToUserSignUpView() {
    Get.toNamed(AppRoutes.signUp);
  }

  static void goToUserSignInView() {
    Get.offAllNamed(AppRoutes.signIn);
  }

  static void goToLogoutView() {
    Get.offAllNamed(AppRoutes.userLogout);
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
    Get.toNamed(AppRoutes.userSubmitAd,
        parameters: {'adDocumentId': adDocumentId});
  }

  static void goToUserAdsListMenuView() {
    Get.offNamed(AppRoutes.userAdsList);
  }

  static void goToUserWalletScreenView() {
    Get.offNamed(AppRoutes.userWalletScreen);
  }

  /// manager module --------------------------------------------------------------------------

  static void goToManagerSignUpView() {
    Get.toNamed(AppRoutes.managerSignUp);
  }

  /// admin module --------------------------------------------------------------------------

  static void goToAdminSignInView() {
    Get.toNamed(AppRoutes.adminSignIn);
  }

  static void goToAdminHomePageView() {
    Get.offAllNamed(AppRoutes.adminHomePage);
  }

  static void goToAdminAdsMenuView() {
    Get.offAllNamed(AppRoutes.adminAdsList);
  }

  static void goToAdminSubmitAdScreenView({required String adDocumentId}) {
    Get.toNamed(AppRoutes.adminSubmitAd,
        parameters: {'adDocumentId': adDocumentId});
  }

  /*static void goToAdminSubmitAdScreenView() {
    Get.toNamed(AppRoutes.adminSubmitAd);
  }*/

  /// Go to back Page / Close Pages --------------------------------------------

  static void goToBack() {
    Get.back();
  }
}
