import 'package:RatingRadar_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';

class AdminCustomDropdown extends StatefulWidget {
  List<String> dropDownItems;
  String selectedItem;
  Function(int index) onItemSelected;

  AdminCustomDropdown(
      {super.key,
      required this.dropDownItems,
      required this.selectedItem,
      required this.onItemSelected});

  @override
  State<AdminCustomDropdown> createState() => _AdminCustomDropdownState();
}

class _AdminCustomDropdownState extends State<AdminCustomDropdown> {
  OverlayEntry? overlayEntry;
  GlobalKey buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeUtils = ThemeColorsUtil(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            showPopUp(themeUtils);
          },
          child: Row(
            key: buttonKey,
            children: [
              Padding(
                padding: EdgeInsets.only(right: Dimens.ten),
                child: Text(
                  widget.selectedItem,
                  style: AppStyles.style14Normal
                      .copyWith(color: themeUtils.whiteDarkCharcoalSwitchColor),
                ),
              ),
              CommonWidgets.fromSvg(
                svgAsset: SvgAssets.downArrowIcon,
                width: Dimens.nine,
                height: Dimens.nine,
                color: themeUtils.primaryColorSwitch,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showPopUp(ThemeColorsUtil themeUtils) {
    if (overlayEntry != null) return;

    final buttonRenderBox =
        buttonKey.currentContext!.findRenderObject() as RenderBox?;
    final buttonPosition = buttonRenderBox!.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          hidePopUp();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              right: Dimens.sixtyFive,
              top: buttonPosition.dy +
                  (buttonRenderBox.size.height + Dimens.four),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: Dimens.oneHundredSixtyFive,
                  decoration: BoxDecoration(
                      color: themeUtils.darkGrayWhiteSwitchColor,
                      borderRadius: BorderRadius.circular(Dimens.eight)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Dimens.ten,
                          top: Dimens.thirteen,
                          bottom: Dimens.four,
                        ),
                        child: InkWell(
                          onTap: () {
                            hidePopUp();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'sort_by'.tr,
                                style: AppStyles.style12Normal.copyWith(
                                    color: ColorValues.lightGrayColor),
                              ),
                              CommonWidgets.fromSvg(
                                  svgAsset: SvgAssets.dropdownDownArrowIcon,
                                  margin:
                                      EdgeInsets.only(right: Dimens.fifteen))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Dimens.five),
                        child: const Divider(
                          color: ColorValues.blackColor,
                          thickness: 0.41,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.dropDownItems.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              widget.onItemSelected(index);
                              hidePopUp();
                            },
                            child: Container(
                              color: widget.selectedItem ==
                                      widget.dropDownItems[index]
                                  ? themeUtils.primaryLightColorSwitch
                                  : ColorValues.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimens.five,
                                  horizontal: Dimens.thirteen),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.dropDownItems[index],
                                      style: AppStyles.style12SemiLight
                                          .copyWith(
                                              color: widget.selectedItem ==
                                                      widget
                                                          .dropDownItems[index]
                                                  ? themeUtils
                                                      .blackWhiteSwitchColor
                                                  : themeUtils
                                                      .whiteBlackSwitchColor),
                                    ),
                                    widget.selectedItem ==
                                            widget.dropDownItems[index]
                                        ? Icon(
                                            Icons.check_rounded,
                                            color: themeUtils
                                                .blackWhiteSwitchColor,
                                          )
                                        : SizedBox.shrink(),
                                  ]),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void hidePopUp() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
