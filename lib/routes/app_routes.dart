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

  /// manager module ---------------------------------------------------------------
  static const managerSignUp = _Routes.managerSignUp;

  /// admin module ---------------------------------------------------------------
  static const adminSignIn = _Routes.adminSignIn;
  static const adminHomePage = _Routes.adminHomePage;
  static const adminAllAds = _Routes.adminAllAds;
  static const adminAdsList = _Routes.adminAdsList;
  static const adminSubmitAd = _Routes.adminSubmitAd;
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

  /// manager module ----------------------------------------------------------------
  static const managerSignUp = '/manager/signup';

  /// admin module ----------------------------------------------------------------
  static const adminSignIn = '/admin/sign-in';
  static const adminHomePage = '/admin/homepage';
  static const adminAllAds = '/admin/admin-all-ads-list';
  static const adminAdsList = '/admin/ads-list';
  static const adminSubmitAd = '/admin/admin-submit-ad';
}
