import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../homepage/model/admin_homepage_recent_user_company_model.dart';

class AdminAllUserController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  Rxn<List<AdminHomepageRecentUserCompanyModel>> userList = Rxn<List<AdminHomepageRecentUserCompanyModel>>();

  Future getUserList({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentUserCompanyModel>? getLimitedUserList = await DatabaseHelper.instance.getAllUsersList(sortBy: sortBy, nDataPerPage: 5, searchTerm: searchTerm);
    userList.value = getLimitedUserList;
    Get.context?.loaderOverlay.hide();
  }
}
