import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:RatingRadar_app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      return null; // Allow the navigation to continue
    } else {
      return GetNavConfig.fromRoute(AppRoutes.signIn); // Redirect to login if not logged in
    }
  }

  Future<bool> isUserLoggedIn() async {
    // String? userId = await PreferencesManager.getUserId();
    String? userId = await DatabaseHelper.instance.getCurrentUserUid();
    return userId != null && userId.isNotEmpty;
  }
}
