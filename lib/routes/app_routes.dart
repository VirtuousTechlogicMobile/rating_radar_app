part of 'app_pages.dart';

abstract class AppRoutes {
  /// user module ------------------------------------------------------------------
  static const signUp = _Routes.userSignUp;
  static const signIn = _Routes.signIn;
  static const userLogout = _Routes.userLogout;
  static const emailConformation = _Routes.emailConformation;
  static const userHomePage = _Routes.userHomePage;
  static const userAllAds = _Routes.userAllAds;
  static const userSubmitAd = _Routes.userSubmitAd;
  static const userAdsList = _Routes.userAdsList;
  static const userWalletScreen = _Routes.userWalletScreen;
  static const userReferralScreen = _Routes.userReferralScreen;
  static const userMyAccountScreen = _Routes.userMyAccountScreen;
  static const userPaymentMethodScreen = _Routes.userPaymentMethodScreen;
  static const userChangePasswordScreen = _Routes.userChangePasswordScreen;
  static const userDeleteAccountScreen = _Routes.userDeleteAccountScreen;

  /// manager module ---------------------------------------------------------------
  static const managerSignUp = _Routes.managerSignUp;

  /// admin module ---------------------------------------------------------------
  static const adminSignIn = _Routes.adminSignIn;
  static const adminHomePage = _Routes.adminHomePage;
  static const adminAllAds = _Routes.adminAllAds;
  static const adminAdsList = _Routes.adminAdsList;
  static const adminCreateAd = _Routes.adminCreateAd;
}

abstract class _Routes {
  /// user module ------------------------------------------------------------------
  static const userSignUp = '/user/signup';
  static const signIn = '/sign-in';
  static const userLogout = '/user/logout';
  static const emailConformation = '/user/email-conformation';
  static const userHomePage = '/user/homepage';
  static const userAllAds = '/user/all-ads-list';
  static const userSubmitAd = '/user/submit-ad';
  static const userAdsList = '/user/ads-list';
  static const userWalletScreen = '/user/wallet';
  static const userReferralScreen = '/user/referral';
  static const userMyAccountScreen = '/user/settings/my-account';
  static const userPaymentMethodScreen = '/user/settings/payment-method';
  static const userChangePasswordScreen = '/user/settings/change-password';
  static const userDeleteAccountScreen = '/user/settings/delete-account';

  /// manager module ----------------------------------------------------------------
  static const managerSignUp = '/manager/signup';

  /// admin module ----------------------------------------------------------------
  static const adminSignIn = '/admin/sign-in';
  static const adminHomePage = '/admin/homepage';
  static const adminAllAds = '/admin/admin-all-ads-list';
  static const adminAdsList = '/admin/ads-list';
  static const adminCreateAd = '/admin/admin-create-ad';
}
