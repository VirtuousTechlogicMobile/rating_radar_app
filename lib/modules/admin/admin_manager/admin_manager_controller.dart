import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../helper/database_helper/database_helper.dart';
import 'model/manager_model.dart';

class AdminManagerController extends GetxController {
  TextEditingController managerNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController managerEmpIdController = TextEditingController();
  TextEditingController aadharImageController = TextEditingController();
  TextEditingController panImageController = TextEditingController();
  TextEditingController gstImageController = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isCancle = false.obs;
  Rxn<XFile> pickedImage = Rxn<XFile>();
  RxString managerEmpId = ''.obs;
  Rxn<ManagerModel> managerData = Rxn<ManagerModel>();
  List<String> adsListDropDownList = ['newest'.tr, 'oldest'.tr, 'all'.tr];
  RxInt selectedDropDownIndex = 0.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  Rxn<List<ManagerModel>> managerList = Rxn<List<ManagerModel>>();

  Future getManagerList({required int sortBy, String? searchTerm}) async {
    Get.context?.loaderOverlay.show();
    List<ManagerModel>? getLimitedManagerList =
        await DatabaseHelper.instance.getAllManagersList(nDataPerPage: 5, sortBy: sortBy, searchTerm: searchTerm);
    managerList.value = getLimitedManagerList;
    Get.context?.loaderOverlay.hide();
  }

  void setManagerData(ManagerModel manager) {
    managerNameController.text = manager.username ?? '';
    companyEmailController.text = manager.email ?? '';
    phoneNumberController.text = manager.phoneNumber ?? '';
    cityController.text = manager.city ?? '';
    stateController.text = manager.state ?? '';
    panNumberController.text = manager.panNumber ?? '';
    gstNumberController.text = manager.companyGSTNumber ?? '';
    aadharNumberController.text = manager.aadharNumber ?? '';
    passwordController.text = manager.password ?? '';
    managerEmpIdController.text = manager.managerId ?? '';
    aadharImageController.text = manager.aadharImage ?? '';
    panImageController.text = manager.panImage ?? '';
    gstImageController.text = manager.gstImage ?? '';
  }

  void ClearManagerData() {
    managerNameController.clear();
    companyEmailController.clear();
    phoneNumberController.clear();
    cityController.clear();
    stateController.clear();
    panNumberController.clear();
    gstNumberController.clear();
    aadharNumberController.clear();
    passwordController.clear();
    managerEmpIdController.clear();
    aadharImageController.clear();
    panImageController.clear();
    gstImageController.clear();
  }
}
