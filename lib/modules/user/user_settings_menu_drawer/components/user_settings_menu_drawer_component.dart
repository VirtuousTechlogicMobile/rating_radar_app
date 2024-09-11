import 'package:RatingRadar_app/common/common_widgets.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:RatingRadar_app/constant/styles.dart';
import 'package:flutter/material.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../drawer/model/menu_data_model.dart';

class UserSettingsMenuDrawerComponent extends StatelessWidget {
  final MenuDataModel menuDataModel;
  final bool isSelected;
  final Function(MenuDataModel selectedMenu) onSelectMenuItem;

  const UserSettingsMenuDrawerComponent({
    super.key,
    required this.menuDataModel,
    required this.isSelected,
    required this.onSelectMenuItem,
  });

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);

    return InkWell(
      onTap: () {
        onSelectMenuItem(menuDataModel);
      },
      child: Container(
        padding: EdgeInsets.only(top: Dimens.eight, bottom: Dimens.eight, right: Dimens.twelve, left: Dimens.eight),
        decoration: BoxDecoration(color: isSelected ? themeUtils.primaryColorSwitch : ColorValues.transparent, borderRadius: BorderRadius.circular(Dimens.twentyFive)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidgets.fromSvg(
              svgAsset: menuDataModel.prefixSvgIcon,
              color: isSelected ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor,
              height: menuDataModel.svgIconHeight ?? Dimens.twentyFour,
              width: menuDataModel.svgIconWidth ?? Dimens.twentyFour,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.twelve),
              child: Text(
                menuDataModel.menuName,
                style: AppStyles.style14SemiBold.copyWith(
                  color: isSelected ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor,
                ),
              ),
            ),
            if (menuDataModel.isShowRightIcon)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CommonWidgets.fromSvg(svgAsset: SvgAssets.rightArrowIcon, color: isSelected ? themeUtils.blackWhiteSwitchColor : themeUtils.whiteBlackSwitchColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
