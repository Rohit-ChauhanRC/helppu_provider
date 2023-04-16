import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';

class MyEmployeeRegistrationController extends GetxController {
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  UserRepository _userRepository;

  MyEmployeeRegistrationController() {
    _userRepository = UserRepository();
  }

  final RxString _name = RxString("");
  String get name => this._name.value;
  set name(String str) => this._name.value = str;

  final RxString _email = RxString("");
  String get email => this._email.value;
  set email(String str) => this._email.value = str;

  final RxString _phone_number = RxString("");
  String get phone_number => this._phone_number.value;
  set phone_number(String str) => this._phone_number.value = str;

  final RxString _password = RxString("");
  String get password => this._password.value;
  set password(String str) => this._password.value = str;

  //final Rx<User> _currentUser = Rx<User>(null);
  //User get currentUser => this._currentUser.value;
  //set currentUser(User user) => this._currentUser.value = user;
  final Rx<User> currentUser = Get.find<AuthService>().newUser;
  GetStorage _box;

  void removeUser() async {
    await _box.remove('newUser');
  }

  void register() async {
    Get.focusScope.unfocus();
    debugPrint("${currentUser}");
    //if (registerFormKey.currentState.validate()) {
    //  //registerFormKey.currentState.save();
    //  loading.value = true;
    try {
      currentUser.value = await _userRepository.register(currentUser.value);
      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email, currentUser.value.apiToken);
      loading.value = false;
      debugPrint("id user : ${currentUser}");
      await Get.toNamed(Routes.MY_EMPLOYEE_DETAILS,
          arguments: currentUser.value.id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }
  //}

  @override
  void onInit() {
    removeUser();
    super.onInit();
  }
}
