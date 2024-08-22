import 'package:RatingRadar_app/modules/admin/admin_signin/bindings/admin_signin_binding.dart';
import 'package:RatingRadar_app/modules/admin/admin_signin/view/admin_signin_screen.dart';
import 'package:RatingRadar_app/modules/admin/homepage/bindings/admin_homepage_binding.dart';
import 'package:RatingRadar_app/modules/admin/homepage/view/admin_homepage_screen.dart';
import 'package:RatingRadar_app/modules/manager/manager_signup/bindings/manager_signup_binding.dart';
import 'package:RatingRadar_app/modules/manager/manager_signup/view/manager_signup_screen.dart';
import 'package:RatingRadar_app/modules/user/homepage/bindings/user_homepage_binding.dart';
import 'package:RatingRadar_app/modules/user/homepage/view/user_homepage_screen.dart';
import 'package:RatingRadar_app/modules/user/user_ads_list_menu/bindings/user_ads_list_menu_binding.dart';
import 'package:RatingRadar_app/modules/user/user_ads_list_menu/view/user_ads_list_menu_screen.dart';
import 'package:RatingRadar_app/modules/user/user_all_ads/bindings/user_all_ads_binding.dart';
import 'package:RatingRadar_app/modules/user/user_all_ads/view/user_all_ads_list_screen.dart';
import 'package:RatingRadar_app/modules/user/user_submit_ad/bindings/user_submit_ad_binding.dart';
import 'package:RatingRadar_app/modules/user/user_submit_ad/view/user_submit_ad_screen.dart';
import 'package:get/get.dart';

import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/view/signin_screen.dart';
import '../modules/user/user_conformation/bindings/user_conformation_binding.dart';
import '../modules/user/user_conformation/view/user_conformation_screen.dart';
import '../modules/user/user_signup/bindings/user_signup_binding.dart';
import '../modules/user/user_signup/view/user_signup_screen.dart';

part 'app_routes.dart';

abstract class AppPages {
  static var defaultTransition = Transition.size;
  static final pages = [
    /// user module ------------------------------------------------------------------------
    GetPage(
      name: _Routes.userSignUp,
      page: UserSignUpScreen.new,
      binding: UserSignUpBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.signIn,
      page: UserSignInScreen.new,
      binding: UserSignInBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.emailConformation,
      page: () => UserConformationScreen(email: Get.parameters['email'] ?? ''),
      binding: UserConformationBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.userHomePage,
      page: UserHomepageScreen.new,
      binding: UserHomepageBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.userAllAds,
      page: UserAllAdsListScreen.new,
      binding: UserAllAdsBinding(),
      transitionDuration: const Duration(milliseconds: 700),
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.userSubmitAd,
      page: () => UserSubmitAdScreen(
          adDocumentId: Get.parameters['adDocumentId'] ?? ''),
      binding: UserSubmitAdBinding(),
      transitionDuration: transitionDuration,
      transition: Transition.fade,
    ),

    GetPage(
      name: _Routes.userAdsList,
      page: () => UserAdsListMenuScreen(),
      binding: UserAdsListMenuBinding(),
      transitionDuration: const Duration(milliseconds: 800),
      transition: Transition.fade,
    ),

    /// manager module ------------------------------------------------------------------------

    GetPage(
      name: _Routes.managerSignUp,
      page: ManagerSignUpScreen.new,
      binding: ManagerSignUpBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    /// admin module ------------------------------------------------------------------------

    GetPage(
      name: _Routes.adminSignIn,
      page: AdmSignInScreen.new,
      binding: AdminSignInBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.adminHomePage,
      page: AdminHomepageScreen.new,
      binding: AdminHomepageBinding(),
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),
  ];

  static var transitionDuration = const Duration(milliseconds: 500);
}
