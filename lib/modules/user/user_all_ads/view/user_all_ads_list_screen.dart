import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/modules/user/header/bindings/header_binding.dart';
import 'package:RatingRadar_app/modules/user/user_all_ads/user_all_ads_controller.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/dimens.dart';
import '../../../../routes/route_management.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../../user_homepage/components/user_homepage_components.dart';
import '../../user_homepage/model/user_ads_list_data_model.dart';

class UserAllAdsListScreen extends StatefulWidget {
  const UserAllAdsListScreen({super.key});

  @override
  State<UserAllAdsListScreen> createState() => _UserAllAdsListScreenState();
}

class _UserAllAdsListScreenState extends State<UserAllAdsListScreen> {
  final userAllAdsController = Get.find<UserAllAdsController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userAllAdsController.getAdsList();
    userAllAdsController.scrollController.addListener(
      () => userAllAdsController.onScroll(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Scaffold(
      backgroundColor: themeUtils.screensBgSwitchColor,
      body: Row(
        children: [
          DrawerView(scaffoldKey: scaffoldKey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                screenMainLayout(
                  themeUtils: themeUtils,
                  userAllAdsController: userAllAdsController,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget header() {
  HeaderBinding().dependencies();
  return HeaderView(
    isDashboardScreen: true,
  );
}

Widget screenMainLayout({required ThemeColorsUtil themeUtils, required UserAllAdsController userAllAdsController}) {
  return Expanded(
    child: SingleChildScrollView(
      controller: userAllAdsController.scrollController,
      child: Container(
        margin: EdgeInsets.only(top: Dimens.thirtyFour, left: Dimens.twentyFour, right: Dimens.twentyFour),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.thirty),
          color: themeUtils.deepBlackWhiteSwitchColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 60,
              spreadRadius: 0,
              color: themeUtils.drawerShadowBlackSwitchColor.withOpacity(0.50),
            ),
          ],
        ),
        child: Hero(
          tag: 'userAllAdsList',
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.thirty, vertical: Dimens.forty),
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: Dimens.nine),
                              child: CommonWidgets.autoSizeText(
                                text: 'popular_ads'.tr,
                                textStyle: AppStyles.style24Normal.copyWith(color: themeUtils.whiteBlackSwitchColor, fontWeight: FontWeight.w600),
                                minFontSize: 15,
                                maxFontSize: 24,
                              ),
                            ),
                            CommonWidgets.autoSizeText(
                              text: 'best_recent_ads'.tr,
                              textStyle: AppStyles.style14Normal.copyWith(color: themeUtils.primaryColorSwitch),
                              minFontSize: 8,
                              maxFontSize: 14,
                            ),
                            Obx(
                              () => Wrap(
                                /// calculate the spacing between items
                                spacing: ((constraints.maxWidth - (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) * Dimens.threeHundredTwenty)) /
                                            (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) - 1)) >
                                        0
                                    ? ((constraints.maxWidth - (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) * Dimens.threeHundredTwenty)) /
                                        (((constraints.maxWidth / Dimens.threeHundredTwenty).floor()) - 1))
                                    : Dimens.sixTeen,
                                children: List.generate(
                                  userAllAdsController.adsList.length,
                                  (index) {
                                    return UserAdViewComponent(
                                      themeColorUtil: themeUtils,
                                      userAdsListDataModel: UserAdsListDataModel(
                                        adName: userAllAdsController.adsList[index].adName,
                                        adContent: userAllAdsController.adsList[index].adContent,
                                        byCompany: userAllAdsController.adsList[index].byCompany,
                                        imageUrl: userAllAdsController.adsList[index].imageUrl,
                                        adPrice: 200,
                                      ),
                                      onViewButtonTap: () {
                                        RouteManagement.goToUserSubmitAdScreenView(adDocumentId: userAllAdsController.adsList[index].docId ?? '');
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    ),
  );
}
