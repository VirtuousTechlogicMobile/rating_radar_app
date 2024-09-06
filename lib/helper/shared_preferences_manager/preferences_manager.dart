import 'package:RatingRadar_app/helper/shared_preferences_manager/sharedpref_getter_setters.dart';

abstract class PreferencesManager {
  static Future setUserUid({required String uid}) async {
    await SharedPrefGetterSetters().clearKey('userId');
    await SharedPrefGetterSetters().setString('userId', uid);
  }

  static Future deleteUserUid({required String uid}) async {
    await SharedPrefGetterSetters().clearKey('userId');
  }

  static Future<String?> getUserId() async {
    String? userId = await SharedPrefGetterSetters().getString('userId');
    String? managerId =
        await SharedPrefGetterSetters().getString('managerUserId');
    return userId ?? managerId;
  }

  static Future setManagerUid({required String uid}) async {
    await SharedPrefGetterSetters().setString('managerUserId', uid);
  }

  static Future setDrawerIndex({required int index}) async {
    await SharedPrefGetterSetters().setInt('drawerIndex', index);
  }

  static Future<int> getDrawerIndex() async {
    return await SharedPrefGetterSetters().getInt('drawerIndex') ?? 0;
  }

  /// admin methods ----------------------------------------------------------

  static Future setAdminUid({required String adminUid}) async {
    await SharedPrefGetterSetters().clearKey('AdminId');
    await SharedPrefGetterSetters().setString('AdminId', adminUid);
  }

  static Future<String?> getAdminId() async {
    String? adminId = await SharedPrefGetterSetters().getString('AdminId');
    return adminId;
  }

  static Future setAdminDrawerIndex({required int index}) async {
    await SharedPrefGetterSetters().setInt('adminDrawerIndex', index);
  }

  static Future<int> getAdminDrawerIndex() async {
    return await SharedPrefGetterSetters().getInt('adminDrawerIndex') ?? 0;
  }
}
