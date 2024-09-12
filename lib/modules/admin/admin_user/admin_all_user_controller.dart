import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../homepage/model/admin_homepage_recent_user_company_model.dart';

class AdminAllUserController extends GetxController {
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  ScrollController scrollController1 = ScrollController();
  RxDouble scrollbar1Height = 0.0.obs;
  RxDouble scrollbar1Top = 0.0.obs;
  double scrollSpeedFactor = 2.0;
  ScrollController scrollController2 = ScrollController();
  RxDouble scrollbar2Height = 0.0.obs;
  RxDouble scrollbar2Top = 0.0.obs;
  TextEditingController searchController = TextEditingController();

  Rxn<List<AdminHomepageRecentUserCompanyModel>> userList = Rxn<List<AdminHomepageRecentUserCompanyModel>>();

  void updateScrollbar1Position() {
    final totalItems = userList.value?.length ?? 0; // Total number of items in the list
    final viewportHeight = scrollController1.position.viewportDimension;
    final totalHeight = scrollController1.position.maxScrollExtent + viewportHeight;

    if (totalItems > 0 && totalHeight > 0) {
      scrollbar1Height.value = (viewportHeight / totalHeight) * viewportHeight;
    } else {
      scrollbar1Height.value = viewportHeight; // In case of no items or zero height, make scrollbar cover the whole height
    }

    final scrollPosition = scrollController1.offset;
    final scrollExtent = scrollController1.position.maxScrollExtent;

    if (scrollExtent > 0) {
      scrollbar1Top.value = (scrollPosition / scrollExtent) * (viewportHeight - scrollbar1Height.value);
    } else {
      scrollbar1Top.value = 0.0; // Reset to top if there's no scroll extent
    }
  }

  void onScrollbarPan1Update(DragUpdateDetails details) {
    final scrollExtent = scrollController1.position.maxScrollExtent;
    final newOffset = scrollController1.offset + (details.primaryDelta ?? 0) * scrollSpeedFactor;
    // Ensure the offset remains within the scroll bounds
    scrollController1.jumpTo(newOffset.clamp(0.0, scrollExtent));
  }

  void scrollToTopAfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController1.jumpTo(0.0); // Adjust for scrollController2 if needed
      updateScrollbar1Position(); // Make sure to update scrollbar position as well
    });
  }

  Future getUserList() async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentUserCompanyModel>? getLimitedUserList = await DatabaseHelper.instance.getLimitedUserList(limit: 9);
    userList.value = getLimitedUserList;
    scrollToTopAfterBuild();
    Get.context?.loaderOverlay.hide();
  }

/* Future getAdsData({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    List<UserAdsListDataModel>? submittedAdData = await DatabaseHelper.instance.getsAdminTotalAdsList(
      nDataPerPage: 9,
      pageNumber: selectedPage.value,
      sortBy: sortBy,
      searchTerm: searchTerm,
    );
    if (submittedAdData != null) {
      adminCreatedAdsList.value = submittedAdData;
      isHoveredList.value = List.generate(submittedAdData.length, (_) => false.obs);
    }
    adminCreatedAdsList.refresh();
    Get.context?.loaderOverlay.hide();
  }*/
}
