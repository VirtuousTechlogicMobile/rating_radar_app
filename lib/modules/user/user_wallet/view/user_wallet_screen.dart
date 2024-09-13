import 'dart:math';

import 'package:RatingRadar_app/constant/assets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/modules/user/user_wallet/component/user_transaction_dialogs.dart';
import 'package:RatingRadar_app/modules/user/user_wallet/user_wallet_controller.dart';
import 'package:RatingRadar_app/routes/route_management.dart';
import 'package:RatingRadar_app/utility/theme_colors_util.dart';
import 'package:RatingRadar_app/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_assets_util.dart';
import '../../drawer/view/drawer_view.dart';
import '../../header/view/header_view.dart';
import '../component/user_transactions_sortby_dropdown.dart';
import '../model/user_transaction_interface.dart';

class UserWalletScreen extends StatefulWidget {
  const UserWalletScreen({super.key});

  @override
  State<UserWalletScreen> createState() => _UserWalletScreenState();
}

class _UserWalletScreenState extends State<UserWalletScreen> {
  final userWalletController = Get.find<UserWalletController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ThemeColorsUtil themeUtils;

  late ThemeAssetsUtil themeAssets;

  @override
  void initState() {
    super.initState();
    userWalletController.scrollController.addListener(
      () => userWalletController.onScroll(),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeUtils = ThemeColorsUtil(context);
    themeAssets = ThemeAssetsUtil(context);
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
                screenMainLayout(themeUtils: themeUtils),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return HeaderView(
      isDashboardScreen: false,
      isAdsListScreen: false,
    );
  }

  Widget screenMainLayout({required ThemeColorsUtil themeUtils}) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            margin: EdgeInsets.only(top: Dimens.twenty, left: Dimens.twentyFour, right: Dimens.twentyFour, bottom: Dimens.forty),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.thirty),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.thirtyEight, right: Dimens.thirtyEight, bottom: Dimens.forty),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimens.twentyEight),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: Dimens.ten),
                              child: CommonWidgets.autoSizeText(
                                text: 'wallet'.tr,
                                textStyle: AppStyles.style24Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                minFontSize: 16,
                                maxFontSize: 24,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: Dimens.thirtyFive),
                              child: CommonWidgets.autoSizeText(
                                text: 'in_your_personal_wallet_you_can_store_funds_with_draw_them_and_make_transactions_it_is_completely_safe'.tr,
                                textStyle: AppStyles.style16Light.copyWith(color: themeUtils.whiteBlackSwitchColor),
                                maxLines: 2,
                                minFontSize: 10,
                                maxFontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// balance layout
                      balanceLayout(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: Dimens.eleven, top: Dimens.forty),
                            child: CommonWidgets.autoSizeText(
                              text: 'transactions'.tr,
                              textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                              minFontSize: 10,
                              maxFontSize: 18,
                            ),
                          ),
                          Obx(
                            () => UserTransactionsSortByDropDown(
                              dropDownItems: userWalletController.dropDownItems,
                              selectedItem: userWalletController.dropDownItems[userWalletController.selectedDropDownItemIndex.value],
                              onItemSelected: (int index) {
                                userWalletController.onDropDownValueChanged(index);
                              },
                            ),
                          ),
                        ],
                      ),

                      /// transactions list layout
                      transactionsListLayout(constraints),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget balanceLayout() {
    return Container(
      padding: EdgeInsets.all(Dimens.eleven),
      decoration: BoxDecoration(
        color: themeUtils.darkGraySoftWhiteSwitchColor,
        borderRadius: BorderRadius.circular(Dimens.thirty),
        boxShadow: [
          BoxShadow(
            color: ColorValues.blackColor.withOpacity(0.20),
            blurRadius: 7,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Dimens.threeHundredForty,
            height: Dimens.oneHundredSeventy,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.twentyFive),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.twentyFive),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CommonWidgets.fromSvg(
                    svgAsset: themeAssets.walletBoxBgSwitchImage,
                    boxFit: BoxFit.cover,
                    width: Dimens.threeHundredForty,
                    height: Dimens.oneHundredSeventy,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimens.twentyFive,
                      top: Dimens.twentyFive,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => CommonWidgets.autoSizeText(
                            text: "Rs.${userWalletController.userCurrentBalance.value}",
                            textStyle: AppStyles.style32Bold.copyWith(color: themeUtils.blackWhiteSwitchColor),
                            minFontSize: 22,
                            maxFontSize: 32,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Dimens.ten),
                          child: CommonWidgets.autoSizeText(
                            text: 'your_balance'.tr,
                            textStyle: AppStyles.style18Normal.copyWith(color: themeUtils.blackWhiteSwitchColor),
                            minFontSize: 10,
                            maxFontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimens.fifteen),
            child: SizedBox(
              width: Dimens.threeHundredForty,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// deposit button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        UserTransactionDialogs.showDepositDialog(
                          context: context,
                          amountController: userWalletController.depositController,
                          onChangePaymentOption: (selectedPaymentOption) {},
                          onConfirm: () async {
                            String? docId = await userWalletController.storeUserTransaction(
                              isWithdraw: false,
                              date: DateTime.now(),
                              amount: userWalletController.depositController.text,
                            );
                            if (docId != null) {
                              RouteManagement.goToBack();
                              AppUtility.showSnackBar('deposit_request_submitted_awaiting_admin_approval'.tr, duration: 4);
                              userWalletController.depositController.clear();
                            } else {
                              AppUtility.showSnackBar('something_want_wrong'.tr);
                            }
                            /*UserTransactionInterface withdrawResult = await userWalletController.depositUserAmountFromAdmin();
                            if (withdrawResult is SuccessDepositResult) {
                              RouteManagement.goToBack();
                              AppUtility.showSnackBar(
                                  '${'your_deposit_of'.tr}${userWalletController.withdrawController.text}${'has_been_successfully_added_your_new_balance_is'.tr}${withdrawResult.currentBalance}',
                                  duration: 4);
                              userWalletController.depositController.clear();
                            } else if (withdrawResult is UnsuccessfulTransactionResult) {
                              AppUtility.showSnackBar('something_want_wrong'.tr);
                            }*/
                          },
                          onClose: () {
                            RouteManagement.goToBack();
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Dimens.ten),
                        decoration: BoxDecoration(
                          color: themeUtils.primaryColorSwitch,
                          borderRadius: BorderRadius.circular(Dimens.hundred),
                        ),
                        margin: EdgeInsets.only(right: Dimens.ten),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidgets.autoSizeText(
                              text: 'deposit'.tr,
                              textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.blackWhiteSwitchColor),
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimens.eight),
                              child: CommonWidgets.fromSvg(svgAsset: SvgAssets.walletDepositIcon, color: themeUtils.blackWhiteSwitchColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // divider
                  SizedBox(
                    height: Dimens.twenty,
                    child: VerticalDivider(
                      width: Dimens.one,
                      color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
                    ),
                  ),

                  /// withdraw button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        UserTransactionDialogs.showWithdrawDialog(
                          context: context,
                          onClose: () {
                            RouteManagement.goToBack();
                          },
                          onConfirm: () async {
                            String? docId = await userWalletController.storeUserTransaction(
                              isWithdraw: true,
                              date: DateTime.now(),
                              amount: userWalletController.withdrawController.text,
                            );
                            if (docId != null) {
                              RouteManagement.goToBack();
                              AppUtility.showSnackBar('withdrawal_request_submitted_awaiting_admin_approval'.tr, duration: 4);
                              userWalletController.withdrawController.clear();
                            } else {
                              AppUtility.showSnackBar('something_want_wrong'.tr);
                            }
                            /*UserTransactionInterface withdrawResult = await userWalletController.withdrawUserAmountFromAdmin();
                            if (withdrawResult is SuccessWithdrawResult) {
                              RouteManagement.goToBack();
                              AppUtility.showSnackBar(
                                  '${'success_your_withdrawal_of'.tr}${userWalletController.withdrawController.text}${'has_been_processed_your_new_balance_is'.tr}${withdrawResult.decreasedBalance}',
                                  duration: 4);
                              userWalletController.withdrawController.clear();
                            } else if (withdrawResult is InsufficientBalanceWithdrawResult) {
                              AppUtility.showSnackBar(
                                  '${'insufficient_balance_you_cannot_withdraw_more_than_your_current_balance_of'.tr}${withdrawResult.currentBalance.toStringAsFixed(2)}',
                                  duration: 4);
                            } else if (withdrawResult is UnsuccessfulTransactionResult) {
                              AppUtility.showSnackBar('something_want_wrong'.tr);
                            }*/
                          },
                          amountController: userWalletController.withdrawController,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Dimens.ten),
                        decoration: BoxDecoration(
                          color: themeUtils.primaryColorSwitch,
                          borderRadius: BorderRadius.circular(Dimens.hundred),
                        ),
                        margin: EdgeInsets.only(left: Dimens.ten),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidgets.autoSizeText(
                              text: 'withdraw'.tr,
                              textStyle: AppStyles.style14SemiBold.copyWith(color: themeUtils.blackWhiteSwitchColor),
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Dimens.eight),
                              child: Transform.rotate(
                                angle: 35 * pi,
                                child: CommonWidgets.fromSvg(svgAsset: SvgAssets.walletDepositIcon, color: themeUtils.blackWhiteSwitchColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionsListLayout(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight / 1.5,
      decoration: BoxDecoration(
        color: themeUtils.midNightBlackWhiteSwitchColor,
        borderRadius: BorderRadius.circular(Dimens.thirty),
        boxShadow: [
          BoxShadow(
            color: ColorValues.blackColor.withOpacity(0.15),
            offset: const Offset(1, 1),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: Obx(
        () => Visibility(
          visible: userWalletController.transactionsList.isNotEmpty,
          replacement: Center(
            child: CommonWidgets.autoSizeText(
              text: 'no_data_available_right_now'.tr,
              textStyle: AppStyles.style35SemiBold.copyWith(color: ColorValues.noDataTextColor),
              minFontSize: 20,
              maxFontSize: 35,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: Dimens.twelve),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimens.fifty,
                  width: constraints.maxWidth,
                  padding: EdgeInsets.only(left: Dimens.sixtyFive, top: Dimens.fifteen, bottom: Dimens.fifteen),
                  margin: EdgeInsets.only(left: Dimens.twelve, right: Dimens.twelve, bottom: Dimens.fifteen),
                  decoration: BoxDecoration(
                    color: themeUtils.darkGrayOfWhiteSwitchColor,
                    borderRadius: BorderRadius.circular(Dimens.twentyFive),
                  ),
                  child: tableHeader(),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimens.thirty), bottomRight: Radius.circular(Dimens.thirty)),
                    child: SingleChildScrollView(
                      controller: userWalletController.scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          userWalletController.transactionsList.length,
                          (index) {
                            return MouseRegion(
                              onEnter: (_) => userWalletController.isHoveredList[index].value = true,
                              onExit: (_) => userWalletController.isHoveredList[index].value = false,
                              child: Container(
                                margin: index == (userWalletController.transactionsList.length - 1) ? EdgeInsets.only(bottom: Dimens.twentySix) : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: userWalletController.isHoveredList[index].value ? themeUtils.darkGrayOfWhiteSwitchColor.withOpacity(0.5) : Colors.transparent,
                                  border: userWalletController.isHoveredList[index].value
                                      ? Border.all(
                                          color: themeUtils.borderTableHoverColor,
                                          width: 1,
                                        )
                                      : Border(
                                          top: BorderSide(color: themeUtils.dividerSwitchColor),
                                          bottom: BorderSide(color: themeUtils.dividerSwitchColor),
                                          left: BorderSide.none,
                                          right: BorderSide.none,
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    customTableRow(
                                      name: AppUtility.capitalizeStatus(userWalletController.transactionsList[index].transactionType),
                                      amount: userWalletController.transactionsList[index].amount.toString(),
                                      date: userWalletController.parseDate(userWalletController.transactionsList[index].date).toString(),
                                      transactionId: userWalletController.transactionsList[index].transactionId,
                                      transactionStatus: userWalletController.transactionsList[index].status,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'name'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'date'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'transaction_id'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'amount'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'status'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'action'.tr,
            style: AppStyles.style14SemiBold.copyWith(
              color: themeUtils.whiteBlackSwitchColor.withOpacity(0.50),
            ),
          ),
        ),
      ],
    );
  }

  Widget customTableRow({
    required String name,
    required String date,
    required String transactionId,
    required String amount,
    required String transactionStatus,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Dimens.eighty, right: Dimens.twelve, top: Dimens.twenty, bottom: Dimens.twenty),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: CommonWidgets.autoSizeText(
              text: name,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              maxLines: 3,
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonWidgets.autoSizeText(
              text: date,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 3,
            child: CommonWidgets.autoSizeText(
              text: transactionId,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              maxLines: 2,
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 2,
            child: CommonWidgets.autoSizeText(
              text: amount,
              textStyle: AppStyles.style14SemiBold.copyWith(
                color: themeUtils.fontColorBlackWhiteSwitchColor,
              ),
              minFontSize: 8,
              maxFontSize: 14,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimens.seven,
                  width: Dimens.seven,
                  margin: EdgeInsets.only(right: Dimens.five),
                  decoration: BoxDecoration(
                    color: transactionStatus == CustomStatus.failed
                        ? ColorValues.statusFontColorRed
                        : transactionStatus == CustomStatus.pending
                            ? ColorValues.statusColorYellow
                            : transactionStatus == CustomStatus.canceled
                                ? ColorValues.statusColorBlack
                                : transactionStatus == CustomStatus.received
                                    ? ColorValues.statusColorGreen
                                    : transactionStatus == CustomStatus.approved
                                        ? ColorValues.statusColorGreen
                                        : ColorValues.statusColorGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                Flexible(
                  child: CommonWidgets.autoSizeText(
                    text: AppUtility.capitalizeStatus(transactionStatus),
                    textStyle: AppStyles.style14SemiBold.copyWith(
                      color: transactionStatus == CustomStatus.failed
                          ? ColorValues.statusFontColorRed
                          : transactionStatus == CustomStatus.pending
                              ? ColorValues.statusColorYellow
                              : transactionStatus == CustomStatus.canceled
                                  ? ColorValues.statusColorBlack
                                  : transactionStatus == CustomStatus.received
                                      ? ColorValues.statusColorGreen
                                      : transactionStatus == CustomStatus.approved
                                          ? ColorValues.statusColorGreen
                                          : ColorValues.statusColorGreen,
                    ),
                    minFontSize: 8,
                    maxFontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              width: Dimens.oneHundredNine,
              padding: EdgeInsets.symmetric(vertical: Dimens.six, horizontal: Dimens.fourteen),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themeUtils.primaryColorSwitch,
                borderRadius: BorderRadius.circular(Dimens.hundred),
              ),
              child: Text(
                'details'.tr,
                style: AppStyles.style14SemiBold.copyWith(color: themeUtils.blackWhiteSwitchColor),
              ),
              /*child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimens.seven,
                    width: Dimens.seven,
                    margin: EdgeInsets.only(right: Dimens.five),
                    decoration: BoxDecoration(
                      color: status == CustomStatus.rejected
                          ? ColorValues.statusColorRed
                          : status == CustomStatus.pending
                              ? ColorValues.statusColorYellow
                              : status == CustomStatus.blocked
                                  ? ColorValues.statusColorBlack
                                  : ColorValues.statusColorGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Flexible(
                    child: CommonWidgets.autoSizeText(
                      text: status,
                      textStyle: AppStyles.style14SemiBold.copyWith(
                        color: status == CustomStatus.rejected
                            ? ColorValues.statusColorRed
                            : status == CustomStatus.pending
                                ? ColorValues.statusColorYellow
                                : status == CustomStatus.blocked
                                    ? ColorValues.statusColorBlack
                                    : ColorValues.statusColorGreen,
                      ),
                      minFontSize: 8,
                      maxFontSize: 14,
                    ),
                  ),
                ],
              ),*/
            ),
          )
        ],
      ),
    );
  }
}
