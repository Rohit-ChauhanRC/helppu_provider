import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_provider_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/e_service_product_model.dart';
import '../../../models/option_group_model.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_provider_repository.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/multi_select_dialog.dart';
import '../../global_widgets/select_dialog.dart';

class EServiceFormController extends GetxController {
  final eService = EService().obs;
  final eSubService = EService().obs;
  final optionGroups = <OptionGroup>[].obs;
  final categories = <Category>[].obs;
  final subCategories = <Category>[].obs;
  final products = <Category>[].obs;
  final eProviders = <EProvider>[].obs;
  final eCategory = Category().obs;
  final eSubCategory = Category().obs;
  final eProduct = Category().obs;
  final eProductDetails = EServiceProductModel().obs;

  GlobalKey<FormState> eServiceForm = new GlobalKey<FormState>();
  EServiceRepository _eServiceRepository;
  CategoryRepository _categoryRepository;
  EProviderRepository _eProviderRepository;

  final RxDouble _basicPrice = RxDouble(0);
  double get basicprice => this._basicPrice.value;
  set basicprice(double str) => this._basicPrice.value = str;

  final RxString _productName = RxString("");
  String get productName => this._productName.value;
  set productName(String str) => this._productName.value = str;

  final RxString _productDesc = RxString("");
  String get productDesc => this._productDesc.value;
  set productDesc(String str) => this._productDesc.value = str;

  final RxString _productId = RxString("");
  String get productId => this._productId.value;
  set productId(String str) => this._productId.value = str;

  final RxDouble _finalPrice = RxDouble(0);
  double get finalPrice => this._finalPrice.value;
  set finalPrice(double str) => this._finalPrice.value = str;

  EServiceFormController() {
    _eServiceRepository = new EServiceRepository();
    _categoryRepository = new CategoryRepository();
    _eProviderRepository = new EProviderRepository();
  }

  @override
  void onInit() async {
    var arguments = Get.arguments as Map<String, dynamic>;
    if (arguments != null) {
      eService.value = arguments['eService'] as EService;
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEService();
    super.onReady();
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    await getCategories();
    await getEProviders();
    await getOptionGroups();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message:
              eService.value.name + " " + "page refreshed successfully".tr));
    }
  }

  Future getEService() async {
    if (eService.value.hasData) {
      try {
        eService.value = await _eServiceRepository.get(eService.value.id);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    }
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getCatServiceAll());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getSubCategories(id) async {
    try {
      subCategories.assignAll(
          await _categoryRepository.getUserSelectedSubCategories(id));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getproduct(category_id, subcategory_id) async {
    try {
      products.assignAll(await _categoryRepository.getUserSelecteProducts(
          category_id, subcategory_id));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getProductDetails(
    category_id,
  ) async {
    try {
      eProductDetails.value =
          await _categoryRepository.getProductById(category_id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getEProviders() async {
    try {
      eProviders.assignAll(await _eProviderRepository.getAll());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  List<SelectDialogItem<Category>> getSelectCategoriesItems() {
    return categories.map((element) {
      return SelectDialogItem(element, element.name);
    }).toList();
  }

  List<SelectDialogItem<Category>> getSelectSubCategoriesItems() {
    return subCategories.map((element) {
      return SelectDialogItem(element, element.name);
    }).toList();
  }

  List<SelectDialogItem<Category>> getSelectProduct() {
    return products.map((element) {
      return SelectDialogItem(element, element.name);
    }).toList();
  }

  List<MultiSelectDialogItem<Category>> getMultiSelectCategoriesItems() {
    return categories.map((element) {
      return MultiSelectDialogItem(element, element.name);
    }).toList();
  }

  List<MultiSelectDialogItem<Category>> getSubMultiSelectCategoriesItems() {
    return subCategories.map((element) {
      return MultiSelectDialogItem(element, element.name);
    }).toList();
  }

  List<SelectDialogItem<EProvider>> getSelectProvidersItems() {
    return eProviders.map((element) {
      return SelectDialogItem(element, element.name);
    }).toList();
  }

  Future getOptionGroups() async {
    if (eService.value.hasData) {
      try {
        var _optionGroups =
            await _eServiceRepository.getOptionGroups(eService.value.id);
        optionGroups.assignAll(_optionGroups);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    }
  }

  /*
  * Check if the form for create new service or edit
  * */
  bool isCreateForm() {
    return !eService.value.hasData;
  }

  void createEServiceForm({bool createOptions = false}) async {
    Get.focusScope.unfocus();
    if (eServiceForm.currentState.validate()) {
      try {
        // {"success":false,"message":[["The description field is required."],["The e provider id field is required."],["The product id field is required."]]}
        eService.value.name = productName;
        eService.value.product_d = eProduct.value.id;
        eService.value.description = productDesc;
        eService.value.categories = [eCategory.value];
        eService.value.product = eProduct.value;
        eServiceForm.currentState.save();
        var _eService = await _eServiceRepository.create(eService.value);
        if (createOptions)
          Get.offAndToNamed(Routes.OPTIONS_FORM,
              arguments: {'eService': _eService});
        else
          Get.offAndToNamed(Routes.E_SERVICE, arguments: {
            'eService': _eService,
            'heroTag': 'e_service_create_form'
          });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {}
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
  }

  void updateEServiceForm() async {
    Get.focusScope.unfocus();
    if (eServiceForm.currentState.validate()) {
      try {
        eServiceForm.currentState.save();
        var _eService = await _eServiceRepository.update(eService.value);
        Get.offAndToNamed(Routes.E_SERVICE, arguments: {
          'eService': _eService,
          'heroTag': 'e_service_update_form'
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {}
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
  }

  void deleteEService() async {
    try {
      await _eServiceRepository.delete(eService.value.id);
      Get.offAndToNamed(Routes.E_SERVICES);
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: eService.value.name + " " + "has been removed".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
