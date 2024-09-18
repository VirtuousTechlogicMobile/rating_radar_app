import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_button.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../routes/route_management.dart';
import '../../../../utility/theme_colors_util.dart';

class DeleteComponent extends StatelessWidget {
  const DeleteComponent({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeColorsUtil themeUtils = ThemeColorsUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: themeUtils.blackWhiteSwitchColor,
        borderRadius: BorderRadius.circular(Dimens.thirty),
        border: Border.all(color: themeUtils.primaryColorSwitch),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(Dimens.twentySix),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.autoSizeText(
                text: 'enter_reason_for_blocking_company'.tr,
                textStyle: AppStyles.style18Bold.copyWith(color: themeUtils.whiteBlackSwitchColor),
                minFontSize: 9,
                maxFontSize: 18,
              ),
              Dimens.boxHeight15,
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(Dimens.ten),
                ),
              ),
              Dimens.boxHeight15,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    btnText: 'cancle'.tr,
                    borderRadius: BorderRadius.circular(Dimens.hundred),
                    contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.twentyFour),
                    btnTextColor: themeUtils.whiteBlackSwitchColor,
                    onTap: () {
                      RouteManagement.goToBack();
                    },
                  ),
                  Dimens.boxWidth15,
                  CustomButton(
                    btnText: 'submit'.tr,
                    borderRadius: BorderRadius.circular(Dimens.hundred),
                    contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.thirtyEight),
                    btnTextColor: themeUtils.whiteBlackSwitchColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
