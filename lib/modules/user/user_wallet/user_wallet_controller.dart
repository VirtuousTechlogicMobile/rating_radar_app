import 'dart:developer';

import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/helper/database_helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/date_time_formatter.dart';
import '../../../helper/shared_preferences_manager/preferences_manager.dart';
import 'model/user_transaction_interface.dart';
import 'model/user_transaction_model.dart';

class UserWalletController extends GetxController {
  List<String> dropDownItems = ['deposit'.tr, 'withdraw'.tr, 'ads'.tr];
  RxInt selectedDropDownItemIndex = 0.obs;
  RxList<UserTransactionModel> transactionsList = <UserTransactionModel>[].obs;
  ScrollController scrollController = ScrollController();
  RxList<RxBool> isHoveredList = <RxBool>[].obs;
  RxInt totalDataCount = 0.obs;
  RxnInt selectedPaymentOptionForDeposit = RxnInt();
  TextEditingController withdrawController = TextEditingController();
  TextEditingController depositController = TextEditingController();
  RxString userCurrentBalance = '0'.obs;
  String? userId;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    userId = await PreferencesManager.getUserId();
    await getTransactionData();
    await getUserCurrentBalance();
    await getTotalCounts();
  }

  Future getTotalCounts() async {
    if (selectedDropDownItemIndex.value == 0) {
      totalDataCount.value = await DatabaseHelper.instance.getDepositTransactionsCount();
    } else if (selectedDropDownItemIndex.value == 1) {
      totalDataCount.value = await DatabaseHelper.instance.getWithdrawTransactionsCount();
    } else {
      totalDataCount.value = await DatabaseHelper.instance.getUserApprovedAdsCount();
    }
  }

  Future getTransactionData({UserTransactionModel? adLastDocument}) async {
    Get.context?.loaderOverlay.show();
    List<UserTransactionModel>? tempTransactionList;
    if (selectedDropDownItemIndex.value == 2) {
      /// getting ad data
      tempTransactionList = await DatabaseHelper.instance.getUserAdsTransactionList(
        uId: userId ?? '',
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

  Future getUserCurrentBalance() async {
    userCurrentBalance.value = await DatabaseHelper.instance.getUserCurrentBalance(uId: userId ?? '') ?? '0';
  }

  Future<UserTransactionInterface> withdrawUserAmountFromAdmin() async {
    Get.context?.loaderOverlay.show();
    UserTransactionInterface userWithdrawResult = await DatabaseHelper.instance.withdrawUserBalanceFromAdmin(uId: userId ?? '', newBalance: num.parse(withdrawController.text));
    await getUserCurrentBalance();
    Get.context?.loaderOverlay.hide();
    return userWithdrawResult;
  }

  Future<UserTransactionInterface> depositUserAmountFromAdmin() async {
    Get.context?.loaderOverlay.show();
    UserTransactionInterface userWithdrawResult = await DatabaseHelper.instance.depositUserBalanceFromAdmin(uId: userId ?? '', newBalance: num.parse(depositController.text));
    await getUserCurrentBalance();
    Get.context?.loaderOverlay.hide();
    return userWithdrawResult;
  }

  Future<String?> storeUserTransaction({
    required bool isWithdraw,
    required DateTime date,
    required String amount,
  }) async {
    try {
      Get.context?.loaderOverlay.show();
      String? docId = await DatabaseHelper.instance.storeUserTransaction(
        userTransactionModel: UserTransactionModel(
          uId: userId ?? '',
          transactionType: isWithdraw ? 'withdraw' : 'deposit',
          transactionId: '123456',
          status: CustomStatus.pending,
          date: date,
          amount: num.parse(amount),
        ),
      );
      transactionsList.clear();
      await getTransactionData();
      Get.context?.loaderOverlay.hide();
      return docId;
    } catch (e) {
      log('Exception : $e');
      return null;
    }
  }
}
