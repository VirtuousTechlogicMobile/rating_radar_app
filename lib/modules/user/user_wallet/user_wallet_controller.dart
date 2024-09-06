import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/date_time_formatter.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import 'model/user_transaction_model.dart';

class UserWalletController extends GetxController {
  List<String> dropDownItems = ['deposit'.tr, 'withdraw'.tr, 'ads'.tr];
  RxInt selectedDropDownItemIndex = 0.obs;
  RxList<UserTransactionModel> transactionsList = <UserTransactionModel>[].obs;
  ScrollController scrollController = ScrollController();
  RxList<RxBool> isHoveredList = <RxBool>[].obs;
  RxInt totalDataCount = 0.obs;
  RxnInt selectedPaymentOptionForDeposit = RxnInt();
  RxBool isDialogVisible = false.obs;

  Future getTotalCounts() async {
    if (selectedDropDownItemIndex.value == 0) {
      totalDataCount.value = await DatabaseHelper.instance.getUserApprovedAdsCount();
    } else if (selectedDropDownItemIndex.value == 1) {
      totalDataCount.value = await DatabaseHelper.instance.getWithdrawTransactionsCount();
    } else {
      totalDataCount.value = await DatabaseHelper.instance.getDepositTransactionsCount();
    }
  }

  Future getTransactionData({UserTransactionModel? adLastDocument}) async {
    Get.context?.loaderOverlay.show();
    List<UserTransactionModel>? tempTransactionList;
    String uId = await PreferencesManager.getUserId() ?? '';
    if (selectedDropDownItemIndex.value == 2) {
      /// getting ad data
      tempTransactionList = await DatabaseHelper.instance.getUserAdsTransactionList(
        uId: uId,
        nDataPerPage: 10,
        adLastDocument: adLastDocument,
      );
    } else {
      /// getting data from transaction table
      tempTransactionList = await DatabaseHelper.instance.getUserTransactionsList(
        nDataPerPage: 10,
        isTransactionTypeWithdraw: selectedDropDownItemIndex.value == 1,
        adLastDocument: adLastDocument,
      );
    }
    if (tempTransactionList != null) {
      for (var transactionsData in tempTransactionList) {
        transactionsList.add(transactionsData);
      }
      isHoveredList.value = List.generate(transactionsList.length, (_) => false.obs);
    }
    Get.context?.loaderOverlay.hide();
  }

  Future onDropDownValueChanged(int index) async {
    selectedDropDownItemIndex.value = index;
    transactionsList.clear();
    await getTotalCounts();
    await getTransactionData();
  }

  String parseDate(DateTime dateTime) {
    return DateTimeFormatter.formatTimeStampToDashedDate(dateTime);
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && transactionsList.length != totalDataCount.value) {
      getTransactionData(adLastDocument: transactionsList.last);
    }
  }
}
