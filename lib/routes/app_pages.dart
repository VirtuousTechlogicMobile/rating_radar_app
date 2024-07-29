import 'package:RatingRadar_app/modules/auth/login/bindings/login_binding.dart';
import 'package:RatingRadar_app/modules/auth/login/view/login_screen.dart';
import 'package:RatingRadar_app/modules/welcome/welcome_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

abstract class AppPages {
  static var defaultTransition = Transition.size;
  static final pages = [
    GetPage(
      name: _Routes.welcome,
      page: WelcomeView.new,
      transitionDuration: transitionDuration,
      transition: defaultTransition,
    ),

    GetPage(
      name: _Routes.login,
      page: LoginScreen.new,
      transitionDuration: transitionDuration,
      binding: LoginBinding(),
      transition: defaultTransition,
    ),

    /// ------------------------------------------------------------------------
  ];

  static var transitionDuration = const Duration(milliseconds: 500);
}
