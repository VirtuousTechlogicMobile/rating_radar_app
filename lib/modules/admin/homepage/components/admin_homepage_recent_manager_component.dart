import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/cached_network_image.dart';
import '../../../../common/common_widgets.dart';
import '../../../../common/view_details_user_and_manager.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/dimens.dart';
import '../../../../constant/styles.dart';
import '../../../../utility/theme_colors_util.dart';
import '../../admin_manager/component/add_manager_compoent.dart';
import '../../admin_manager/component/delete_component.dart';
import '../../admin_manager/model/manager_model.dart';

class AdminHomepageRecentManagerComponent extends StatelessWidget {
  final ManagerModel? managerModel;

  const AdminHomepageRecentManagerComponent({super.key, required this.managerModel});

  @override
  Widget build(BuildContext context) {
    final themeColorsUtil = ThemeColorsUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: themeColorsUtil.blackWhiteSwitchColor,
          boxShadow: [
            BoxShadow(spreadRadius: -1, blurRadius: 8, offset: const Offset(0, 2), color: themeColorsUtil.boxShadowContainerColor),
          ],
          border: Border.all(
            color: ColorValues.primaryColorBlue.withOpacity(0.15),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(Dimens.ten)),
      margin: EdgeInsets.only(right: Dimens.nineteen, left: Dimens.twentyFive, bottom: Dimens.eighteen),
      child: Padding(
        padding: EdgeInsets.all(Dimens.sixTeen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              if (managerModel?.profileImg != null && managerModel?.profileImg != '') {
                return ClipOval(
                  child: NxNetworkImage(
                    imageUrl: managerModel?.profileImg ?? '',
                    width: Dimens.fortyEight,
                    height: Dimens.fortyEight,
                    imageFit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(
                  width: Dimens.fortyEight,
                  height: Dimens.fortyEight,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorValues.primaryColorBlue, // Background color for the circle
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    managerModel?.username.substring(0, 2).toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: Dimens.twenty, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.eight, left: Dimens.sixTeen),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: Dimens.eight),
                        child: CommonWidgets.autoSizeText(
                          text: managerModel?.username ?? '',
                          textStyle: AppStyles.style16Bold.copyWith(color: themeColorsUtil.cardTextColor),
                          minFontSize: 16,
                          maxFontSize: 16,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Flexible(
                      child: CommonWidgets.autoSizeText(
                        text: managerModel?.email ?? '',
                        textStyle: AppStyles.style14Normal.copyWith(color: themeColorsUtil.cardTextColor),
                        minFontSize: 10,
                        maxFontSize: 16,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
              ),
              color: themeColorsUtil.whiteBlackSwitchColor,
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(200, 370, 90, 0),
                  items: [
                    PopupMenuItem<int>(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.visibility_outlined, color: themeColorsUtil.whiteBlackSwitchColor),
                        // 'View' icon
                        title: Text('view'.tr),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.edit_outlined, color: themeColorsUtil.whiteBlackSwitchColor), // 'View' icon
                        title: Text('edit'.tr),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.block, color: themeColorsUtil.whiteBlackSwitchColor), // 'View' icon
                        title: Text('block'.tr),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: ListTile(
                        leading: Icon(Icons.delete_outlined, color: themeColorsUtil.whiteBlackSwitchColor), // 'View' icon
                        title: Text('delete'.tr),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 4,
                      child: ListTile(
                        leading: Icon(Icons.check, color: themeColorsUtil.whiteBlackSwitchColor), // 'View' icon
                        title: Text('approved'.tr),
                      ),
                    ),
                  ],
                ).then((value) {
                  // Handle option selection
                  if (value == 0) {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: const AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.493,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: ViewDetailsUserAndManager(
                                title: 'manager_details'.tr,
                                email: managerModel?.email ?? 'Evano@gmail.com',
                                imageUrl: managerModel?.profileImg ??
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                city: managerModel?.state ?? 'Rajkot',
                                state: managerModel?.city ?? 'Gujarat',
                                name: managerModel?.username ?? 'Mr.Evano',
                                panNumber: managerModel?.panNumber ?? 'ABBPC1234A',
                                phone: managerModel?.phoneNumber ?? '369 258 147',
                                userOrManager: 'manager'.tr, //managerModel?.username ?? '',
                                gstNumber: '24AAACH7409R2Z6',
                                gender: 'Male',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (value == 1) {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: const AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.7,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: AddManagerCompoent(
                                managerModel: managerModel,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (value == 2) {
                    // Block action
                  } else if (value == 3) {
                    // Delete action
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: const AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () => FocusScope.of(dialogContext).unfocus(),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.32,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: DeleteComponent(),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (value == 4) {}
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
