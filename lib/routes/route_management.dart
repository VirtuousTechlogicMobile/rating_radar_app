import 'package:get/get.dart';

import 'app_pages.dart';

abstract class RouteManagement {
  /// user module --------------------------------------------------------------------------

  static void goToUserSignUpScreen() {
    Get.offAllNamed(AppRoutes.signUp);
  }

  static void goToUserSignInScreen() {
    Get.offAllNamed(AppRoutes.signIn);
  }

  static void goToUserLogoutScreen() {
    Get.offAllNamed(AppRoutes.userLogout);
  }

  static void goToUserConformationScreen({required String email}) {
    Get.toNamed(AppRoutes.emailConformation, parameters: {'email': email});
  }

  static void goToUserHomePageScreen() {
    Get.offAllNamed(AppRoutes.userHomePage);
  }

  static void goToUserAllAdsListScreen() {
    Get.toNamed(AppRoutes.userAllAds);
  }

  static void goToUserSubmitAdScreen({required String adDocumentId}) {
    Get.toNamed(AppRoutes.userSubmitAd, parameters: {'adDocumentId': adDocumentId});
  }

  static void goToUserAdsListMenuScreen() {
    Get.offNamed(AppRoutes.userAdsList);
  }

  static void goToUserWalletScreen() {
    Get.offNamed(AppRoutes.userWalletScreen);
  }

  static void goToUserReferralScreen() {
    Get.offNamed(AppRoutes.userReferralScreen);
  }

  static void goToUserMyAccountSettingScreen() {
    Get.offNamed(AppRoutes.userMyAccountScreen);
  }

  static void goToUserPaymentMethodSettingScreen() {
    Get.offNamed(AppRoutes.userPaymentMethodScreen);
  }

  static void goToUserChangePasswordScreen() {
    Get.offNamed(AppRoutes.userChangePasswordScreen);
  }

  static void goToUserDeleteAccountScreen() {
    Get.offNamed(AppRoutes.userDeleteAccountScreen);
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

  static void goToAdminCreatedAdScreenView() {
    Get.toNamed(AppRoutes.adminCreateAd);
  }

  static void goToAdminViewScreenView({required String adDocumentId, Function()? whenComplete}) {
    Get.toNamed(AppRoutes.adminViewAd, parameters: {'adDocumentId': adDocumentId})?.whenComplete(
      () {
        if (whenComplete != null) {
          whenComplete();
        }
      },
    );
  }

  static void goToAdminAllUserView() {
    Get.toNamed(AppRoutes.adminAllUser);
  }

  static void goToAdminLogoutView() {
    Get.offAllNamed(AppRoutes.adminLogout);
  }

  static void goToAdminManagerView() {
    Get.offAllNamed(AppRoutes.adminManager);
  }

  /// Go to back Page / Close Pages --------------------------------------------

  static void goToBack() {
    Get.back();
  }
}
