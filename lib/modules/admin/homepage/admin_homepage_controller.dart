import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';

class AdminHomepageController extends GetxController {
  late final AdminHomepageRecentUserCompanyModel adminHomepageRecentUserCompanyModel;
  double scrollSpeedFactor = 2.0;

  ScrollController scrollController1 = ScrollController();
  RxDouble scrollbar1Height = 0.0.obs;
  RxDouble scrollbar1Top = 0.0.obs;

  ScrollController scrollController2 = ScrollController();
  RxDouble scrollbar2Height = 0.0.obs;
  RxDouble scrollbar2Top = 0.0.obs;

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

  void updateScrollbar2Position() {
    final totalItems = companyList.value?.length ?? 0; // Total number of items in the list
    final viewportHeight = scrollController2.position.viewportDimension;
    final totalHeight = scrollController2.position.maxScrollExtent + viewportHeight;

    if (totalItems > 0 && totalHeight > 0) {
      scrollbar2Height.value = (viewportHeight / totalHeight) * viewportHeight;
    } else {
      scrollbar2Height.value = viewportHeight; // In case of no items or zero height, make scrollbar cover the whole height
    }

    final scrollPosition = scrollController2.offset;
    final scrollExtent = scrollController2.position.maxScrollExtent;

    if (scrollExtent > 0) {
      scrollbar2Top.value = (scrollPosition / scrollExtent) * (viewportHeight - scrollbar2Height.value);
    } else {
      scrollbar2Top.value = 0.0; // Reset to top if there's no scroll extent
    }
  }

  void onScrollbarPan2Update(DragUpdateDetails details) {
    final scrollExtent = scrollController2.position.maxScrollExtent;
    final newOffset = scrollController2.offset + (details.primaryDelta ?? 0) * scrollSpeedFactor;

    // Ensure the offset remains within the scroll bounds
    scrollController2.jumpTo(newOffset.clamp(0.0, scrollExtent));
  }

  void scrollToTopAfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController1.jumpTo(0.0); // Adjust for scrollController2 if needed
      updateScrollbar1Position(); // Make sure to update scrollbar position as well
    });
  }

  void scrollToTop2AfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController2.jumpTo(0.0); // Adjust for scrollController2 if needed
      updateScrollbar2Position(); // Make sure to update scrollbar position as well
    });
  }

  List<String> adminDropdownItemList = ['today'.tr, 'lastWeek'.tr, 'lastMonth'.tr, 'lastYear'.tr, 'allTime'.tr];
  RxInt selectedDropdownItemIndex = 0.obs;
  RxList<bool> isViewComponentHoveredList = List.generate(1, (index) => false).obs;

  Rxn<List<AdminHomepageRecentUserCompanyModel>> userList = Rxn<List<AdminHomepageRecentUserCompanyModel>>();

  Future getUserList() async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentUserCompanyModel>? getLimitedUserList = await DatabaseHelper.instance.getLimitedUserList(limit: 9);
    userList.value = getLimitedUserList;
    // Ensure container is visible and scrollbar is updated
    scrollToTopAfterBuild();
    Get.context?.loaderOverlay.hide();
  }

  Rxn<List<AdminHomepageRecentUserCompanyModel>> companyList = Rxn<List<AdminHomepageRecentUserCompanyModel>>();

  Future getCompanyList() async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentUserCompanyModel>? getLimitedUserList = await DatabaseHelper.instance.getLimitedUserList(limit: 9);
    companyList.value = getLimitedUserList;
    // Ensure container is visible and scrollbar is updated
    scrollToTop2AfterBuild();
    Get.context?.loaderOverlay.hide();
  }
}
