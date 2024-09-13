import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/dimens.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:RatingRadar_app/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class AppUtility {
  /// Logger
  static final logger = TalkerFlutter.init();

  static void log(dynamic message, {String? tag}) {
    switch (tag) {
      case 'error':
        logger.error(message);
        break;
      case 'warning':
        logger.warning(message);
        break;
      case 'info':
        logger.info(message);
        break;
      case 'debug':
        logger.debug(message);
        break;
      case 'critical':
        logger.critical(message);
        break;
      default:
        logger.verbose(message);
        break;
    }
  }

  /// Close any open snack bar.

  static void closeSnackBar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Show SnackBar

  static void showSnackBar(String message, {int? duration}) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        margin: EdgeInsets.only(
          left: Dimens.zero,
          right: Dimens.zero,
          top: Dimens.zero,
          bottom: Dimens.zero,
        ),
        borderRadius: Dimens.zero,
        padding: Dimens.edgeInsets16_12,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: Dimens.zero,
        messageText: Text(
          message.toCapitalized(),
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.whiteColor,
          ),
        ),
        shouldIconPulse: false,
        backgroundColor: Theme.of(Get.context!).snackBarTheme.backgroundColor!,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }

  /// format number
  static String formatNumber(double value) {
    return NumberFormat('#,###').format(value);
  }

  static String formatNumberAsMarketValue({required double value, required bool isMarketValueUp}) {
    return isMarketValueUp ? '+${value.toString()}%' : '-${value.toString()}%';
  }

  static String capitalizeStatus(String status) {
    if (status.isNotEmpty) {
      return status[0].toUpperCase() + status.substring(1);
    } else {
      return status;
    }
  }

  static String generateReferralLink({required String uId}) {
    if (uId.isNotEmpty) {
      return 'https://rating-reviews-app.web.app/#/user/signup?user=$uId';
    } else {
      return '';
    }
  }
}
