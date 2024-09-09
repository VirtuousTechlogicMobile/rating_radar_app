import 'package:get/get.dart';

import '../../../constant/assets.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import '../drawer/model/menu_data_model.dart';

class UserSettingsMenuDrawerController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isShowExpandedContent = false.obs;
  RxInt selectedMenuIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDrawerIndex();
  }

  getDrawerIndex() async {
    selectedMenuIndex.value = await PreferencesManager.getDrawerIndex();
  }

  setDrawerIndex(int index) async {
    await PreferencesManager.setDrawerIndex(index: index);
  }

  List<MenuDataModel> menuDataList = [
    MenuDataModel(prefixSvgIcon: SvgAssets.myAccountIcon, menuName: 'my_account'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.paymentMethodIcon, menuName: 'payment_method'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.lockIcon, menuName: 'change_password'.tr),
    MenuDataModel(prefixSvgIcon: SvgAssets.deleteAccountIcon, menuName: 'delete_account'.tr),
  ];
}
