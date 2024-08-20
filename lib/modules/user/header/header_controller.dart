import 'package:get/get.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';

class HeaderController extends GetxController {
  RxBool isSettingsIconHovered = false.obs;
  RxBool isBellIconHovered = false.obs;
  RxString userName = ''.obs;

  getUserName() async {
    String userId = await PreferencesManager.getUserId() ?? '';
    userName.value = await DatabaseHelper.instance.getUserName(uId: userId) ?? '';
  }
}
