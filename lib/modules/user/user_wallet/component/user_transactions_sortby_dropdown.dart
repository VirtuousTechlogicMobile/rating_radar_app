import 'package:RatingRadar_app/common/custom_button.dart';
import 'package:RatingRadar_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_widgets.dart';
import '../../../../common/custom_radio_button.dart';
import '../../../../constant/assets.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';

class UserTransactionsSortByDropDown extends StatefulWidget {
  List<String> dropDownItems;
  String selectedItem;
  Function(int index) onItemSelected;

  UserTransactionsSortByDropDown({super.key, required this.dropDownItems, required this.selectedItem, required this.onItemSelected});

  @override
  State<UserTransactionsSortByDropDown> createState() => _UserTransactionsSortByDropDownState();
}

class _UserTransactionsSortByDropDownState extends State<UserTransactionsSortByDropDown> {
  OverlayEntry? overlayEntry;
  GlobalKey buttonKey = GlobalKey();
  String tempSelectedItem = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempSelectedItem = widget.selectedItem;
  }

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
                  style: AppStyles.style14Normal.copyWith(color: themeUtils.whiteDarkCharcoalSwitchColor),
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

    final buttonRenderBox = buttonKey.currentContext!.findRenderObject() as RenderBox?;
    final buttonPosition = buttonRenderBox!.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          tempSelectedItem = widget.selectedItem;
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
              top: buttonPosition.dy + (buttonRenderBox.size.height + Dimens.four),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: Dimens.twoHundredForty,
                  padding: EdgeInsets.only(bottom: Dimens.thirteen),
                  decoration: BoxDecoration(
                    color: themeUtils.blackWhiteSwitchColor,
                    borderRadius: BorderRadius.circular(Dimens.eight),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: ColorValues.blackColor.withOpacity(0.8),
                        spreadRadius: 0,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.dropDownItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: index == 0 ? Dimens.thirtyTwo : Dimens.twelve, left: Dimens.sixTeen, bottom: Dimens.twelve),
                            child: InkWell(
                              onTap: () {
                                tempSelectedItem = widget.dropDownItems[index];
                                hidePopUp();
                                showPopUp(themeUtils);
                              },
                              child: CustomRadioButton(
                                isSelected: widget.dropDownItems[index] == tempSelectedItem,
                                labelText: widget.dropDownItems[index],
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                              btnText: 'cancel'.tr,
                              onTap: () {
                                tempSelectedItem = widget.selectedItem;
                                hidePopUp();
                              },
                              borderRadius: BorderRadius.circular(Dimens.hundred),
                              contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.twelve),
                            ),
                            CustomButton(
                              btnText: 'ok'.tr,
                              onTap: () {
                                widget.onItemSelected(widget.dropDownItems.indexOf(tempSelectedItem));
                                hidePopUp();
                              },
                              margin: EdgeInsets.only(left: Dimens.eight, right: Dimens.twelve),
                              borderRadius: BorderRadius.circular(Dimens.hundred),
                              contentPadding: EdgeInsets.symmetric(vertical: Dimens.ten, horizontal: Dimens.twelve),
                            ),
                          ],
                        ),
                      )
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
