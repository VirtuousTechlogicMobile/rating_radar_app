import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserReferralController extends GetxController {
  RxDouble widgetWidth = 500.0.obs;
  GlobalKey textKey = GlobalKey();

  void getTextWidth() {
    final RenderBox renderBox = textKey.currentContext?.findRenderObject() as RenderBox;
    widgetWidth.value = renderBox.size.width;
  }
}
