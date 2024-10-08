part of 'app_pages.dart';

abstract class AppRoutes {
  /// user module ------------------------------------------------------------------
  static const signUp = _Routes.userSignUp;
  static const signIn = _Routes.signIn;
  static const emailConformation = _Routes.emailConformation;
  static const userHomePage = _Routes.userHomePage;
  static const userAllAds = _Routes.userAllAds;
  static const userSubmitAd = _Routes.userSubmitAd;
  static const userAdsList = _Routes.userAdsList;

  /// manager module ---------------------------------------------------------------
  static const managerSignUp = _Routes.managerSignUp;
}

abstract class _Routes {
  /// user module ------------------------------------------------------------------
  static const userSignUp = '/user/signup';
  static const signIn = '/sign-in';
  static const emailConformation = '/user/email-conformation';
  static const userHomePage = '/user/homepage';
  static const userAllAds = '/user/all-ads-list';
  static const userSubmitAd = '/user/submit-ad';
  static const userAdsList = '/user/ads-list';

  /// manager module ----------------------------------------------------------------
  static const managerSignUp = '/manager/signup';
}
