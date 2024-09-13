import 'package:RatingRadar_app/helper/shared_preferences_manager/preferences_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UserReferralController extends GetxController {
  RxDouble widgetWidth = 500.0.obs;
  GlobalKey textKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  RxString userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserId();
  }

  Future getUserId() async {
    userId.value = await PreferencesManager.getUserId() ?? '';
  }

  void getTextWidth() {
    final RenderBox renderBox = textKey.currentContext?.findRenderObject() as RenderBox;
    widgetWidth.value = renderBox.size.width;
  }

  void selectText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  Future sendEmail({required String receiverEmail, required String referralLink}) async {
    const String subject = 'Review & Ratings app';
    final String messageBody =
        'Hi, \n\nI wanted to share something exciting with you. I\'ve been using Ratings & Reviews Website, and it\'s been fantastic! As a special offer, you can use my referral link to join and get some exclusive benefits.\nHere\'s your referral link:  $referralLink\n\nWith this link, you’ll earn money by rating on ads. It\'s a great way to get started and enjoy all the amazing features that Ratings & Reviews has to offer.';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: receiverEmail,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(messageBody)}',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
