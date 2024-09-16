import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/database_helper/database_helper.dart';
import '../homepage/model/admin_homepage_recent_manager_model.dart';

class AdminManagerController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  Rxn<List<AdminHomepageRecentManagerModel>> managerList = Rxn<List<AdminHomepageRecentManagerModel>>();

  Future getManagerList({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentManagerModel>? getLimitedManagerList =
        await DatabaseHelper.instance.getAllManagersList(nDataPerPage: 5, sortBy: sortBy, searchTerm: searchTerm);
    managerList.value = getLimitedManagerList;
    Get.context?.loaderOverlay.hide();
  }
}
