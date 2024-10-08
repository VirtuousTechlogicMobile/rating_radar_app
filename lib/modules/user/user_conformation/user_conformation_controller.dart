import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../helper/database_helper/database_helper.dart';

class UserConformationController extends GetxController {
  RxBool isShowLoadingOnButton = false.obs;
  Timer? timer;
  late AnimationController animationController;
  RxInt start = 60.obs;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  Future resendEmailLink() async {
    await DatabaseHelper.instance.sendLinkToEmail();
    start.value = 60;
    startTimer();
  }

  Future<bool> onRefresh() async {
    animationController.repeat();
    bool isUserVerified = await DatabaseHelper.instance.checkIsUserVerified();
    await Future.delayed(const Duration(milliseconds: 600));
    animationController.stop();
    return isUserVerified;
  }

  Future<String> onLogout() async {
    String isUserLogout = await DatabaseHelper.instance.logoutUser();
    return isUserLogout;
  }
}
