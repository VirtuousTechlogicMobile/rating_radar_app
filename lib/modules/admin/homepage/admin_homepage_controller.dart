import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';

class AdminHomepageController extends GetxController {
  Future<String?> getUserUid() async {
    return await PreferencesManager.getUserId();
  }

  double scrollSpeedFactor = 3.0;

  ScrollController scrollController1 = ScrollController();
  RxDouble scrollbar1Height = 0.0.obs;
  RxDouble scrollbar1Top = 0.0.obs;

  ScrollController scrollController2 = ScrollController();
  RxDouble scrollbar2Height = 0.0.obs;
  RxDouble scrollbar2Top = 0.0.obs;

  void updateScrollbar1Position() {
    final scrollPosition = scrollController1.offset;
    final scrollExtent = scrollController1.position.maxScrollExtent;
    final viewportHeight = scrollController1.position.viewportDimension;
    final double topPadding = Dimens.sixTeen; // Padding from the top
    final double bottomPadding = Dimens.twentyFive; // Padding from the bottom

    // Calculate the available height after considering the padding
    final availableHeight = viewportHeight - topPadding - bottomPadding;

    // Calculate scrollbar height considering the available height
    scrollbar1Height.value = availableHeight * availableHeight / scrollExtent;

    // Calculate the top position of the scrollbar thumb with padding
    scrollbar1Top.value = topPadding +
        (scrollPosition / scrollExtent) *
            (availableHeight - scrollbar1Height.value);
  }

  void onScrollbarPan1Update(DragUpdateDetails details) {
    final scrollExtent = scrollController1.position.maxScrollExtent;
    final newOffset = scrollController1.offset +
        (details.primaryDelta ?? 0) * scrollSpeedFactor;
    // final newOffset = scrollController.offset + (details.primaryDelta ?? 0);

    scrollController1.jumpTo(newOffset.clamp(0.0, scrollExtent));
  }

  void updateScrollbar2Position() {
    final scrollPosition = scrollController2.offset;
    final scrollExtent = scrollController2.position.maxScrollExtent;
    final viewportHeight = scrollController2.position.viewportDimension;
    final double topPadding = Dimens.sixTeen; // Padding from the top
    final double bottomPadding = Dimens.twentyFive; // Padding from the bottom

    // Calculate the available height after considering the padding
    final availableHeight = viewportHeight - topPadding - bottomPadding;

    // Calculate scrollbar height considering the available height
    scrollbar2Height.value = availableHeight * availableHeight / scrollExtent;

    // Calculate the top position of the scrollbar thumb with padding
    scrollbar2Top.value = topPadding +
        (scrollPosition / scrollExtent) *
            (availableHeight - scrollbar2Height.value);
  }

  void onScrollbarPan2Update(DragUpdateDetails details) {
    final scrollExtent = scrollController2.position.maxScrollExtent;
    final newOffset = scrollController2.offset +
        (details.primaryDelta ?? 0) * scrollSpeedFactor;

    scrollController2.jumpTo(newOffset.clamp(0.0, scrollExtent));
  }

  List<String> adminDropdownItemList = [
    'today'.tr,
    'lastWeek'.tr,
    'lastMonth'.tr,
    'lastYear'.tr,
    'allTime'.tr
  ];
  RxInt selectedDropdownItemIndex = 0.obs;
  RxList<bool> isViewComponentHoveredList =
      List.generate(1, (index) => false).obs;

  Rxn<List<AdminHomepageRecentUserCompanyModel>> userList =
      Rxn<List<AdminHomepageRecentUserCompanyModel>>();

  Future getUserList() async {
    Get.context?.loaderOverlay.show();
    List<AdminHomepageRecentUserCompanyModel>? getLimitedUserList =
        await DatabaseHelper.instance.getLimitedUserList(limit: 9);
    userList.value = getLimitedUserList;
    Get.context?.loaderOverlay.hide();
  }

/*
  List<AdminHomepageRecentUserCompanyModel>
      adminHomepageRecentUserCompanyModel = [
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label",
        email: "abc@gmail.com",
        imageUrl:
            "https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg"),
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label", email: "abc@gmail.com", imageUrl: ''),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin", email: "admin@gmail.com", imageUrl: ""),
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label", email: "Headlinelabel@gmail.com", imageUrl: ""),
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label", email: "Headlinelabel@gmail.com", imageUrl: ""),
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label", email: "Headlinelabel@gmail.com", imageUrl: ""),
    AdminHomepageRecentUserCompanyModel(
        name: "Headline label",
        email: "Headlinelabel@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
    AdminHomepageRecentUserCompanyModel(
        name: "admin",
        email: "admin@gmail.com",
        imageUrl: SvgAssets.drawerAdsListIcon),
  ];*/
}
