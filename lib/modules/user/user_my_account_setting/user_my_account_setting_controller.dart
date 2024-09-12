import 'dart:developer';

import 'package:RatingRadar_app/constant/strings.dart';
import 'package:RatingRadar_app/helper/shared_preferences_manager/preferences_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/database_helper/database_helper.dart';
import '../user_signup/model/user_signup_model.dart';

class UserMyAccountSettingController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString userGender = ''.obs;
  RxBool isShowPassword = false.obs;
  Rxn<XFile> pickedImage = Rxn<XFile>();
  RxString userId = ''.obs;
  Rxn<UserDataModel> userData = Rxn<UserDataModel>();

  @override
  Future<void> onInit() async {
    Get.context?.loaderOverlay.show();
    super.onInit();
    await getUserId();
    await getUserData();
    Get.context?.loaderOverlay.hide();
  }

  Future getUserId() async {
    userId.value = await PreferencesManager.getUserId() ?? '';
  }

  Future getUserProfilePicture() async {
    String userProfilePicture = await DatabaseHelper.instance.getUserProfilePicture(uId: userId.value) ?? '';
    if (userData.value != null) {
      userData.value = userData.value!.copyWith(newProfileImage: userProfilePicture);
    }
  }

  Future getUserData() async {
    userData.value = await DatabaseHelper.instance.getSpecificUserData(uId: userId.value);
    fullNameController.text = userData.value?.username ?? '';
    emailController.text = userData.value?.email ?? '';
    phoneNumberController.text = userData.value?.phoneNumber ?? '';
    cityController.text = userData.value?.city ?? '';
    stateController.text = userData.value?.state ?? '';
    panNumberController.text = userData.value?.panNumber ?? '';
    passwordController.text = userData.value?.password ?? '';
    userGender.value = userData.value?.gender ?? '';
  }

  Future<String?> updateUserData() async {
    Get.context?.loaderOverlay.show();
    String? userUpdateStatus = await DatabaseHelper.instance.updateUserData(
      userDataModel: UserDataModel(
        email: '',
        username: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        password: '',
        panNumber: panNumberController.text,
        state: stateController.text,
        city: cityController.text,
        gender: userGender.value,
        uId: userId.value,
        referredBy: '',
      ),
    );
    await getUserData();
    Get.context?.loaderOverlay.hide();
    return userUpdateStatus;
  }

  Future<String?> pickAndUpdateImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        pickedImage.value = file;
        Get.context?.loaderOverlay.show();

        /// update image
        String? profilePictureUrl = await DatabaseHelper.instance.updateUserProfilePictureInStorage(
          uId: userId.value,
          newFileData: pickedImage.value,
          oldProfileImage: userData.value?.profileImage,
        );

        /// update profile picture in users table
        if (profilePictureUrl != null) {
          String? updateStatus = await DatabaseHelper.instance.updateUserProfilePictureInFireStore(profilePictureUrl: profilePictureUrl, uId: userId.value);
          if (updateStatus == CustomStatus.success) {
            await getUserProfilePicture();
            Get.context?.loaderOverlay.hide();
            return CustomStatus.success;
          } else {
            Get.context?.loaderOverlay.hide();
            return null;
          }
        } else {
          Get.context?.loaderOverlay.hide();
          return null;
        }
      } else {
        Get.context?.loaderOverlay.hide();
        return null;
      }
    } catch (e) {
      log("Exception : $e");
      Get.context?.loaderOverlay.hide();
      return null;
    }
  }

  Future<String?> removeProfilePicture() async {
    Get.context?.loaderOverlay.show();
    await DatabaseHelper.instance.removeUserProfilePictureInStorage(oldProfileImageUrl: userData.value?.profileImage ?? '');
    String? updateStatus = await DatabaseHelper.instance.updateUserProfilePictureInFireStore(profilePictureUrl: '', uId: userId.value);
    if (updateStatus == CustomStatus.success) {
      await getUserProfilePicture();
      Get.context?.loaderOverlay.hide();
      return CustomStatus.success;
    } else {
      Get.context?.loaderOverlay.hide();
      return null;
    }
  }
}
