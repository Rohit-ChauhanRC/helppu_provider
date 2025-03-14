import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import 'settings_service.dart';

class AuthService extends GetxService {
  final user = User().obs;
  final newUser = User().obs;
  GetStorage _box;

  UserRepository _usersRepo;

  AuthService() {
    _usersRepo = new UserRepository();
    _box = new GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((User _user) {
      if (Get.isRegistered<SettingsService>()) {
        Get.find<SettingsService>().address.value.userId = _user.id;
      }
      _box.write('current_user', _user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future<AuthService> inituser() async {
    newUser.listen((User _user) {
      if (Get.isRegistered<SettingsService>()) {
        Get.find<SettingsService>().address.value.userId = _user.id;
      }
      _box.write('newUser', _user.toJson());
    });
    await getCurrentUsernewUser();
    return this;
  }

  Future getCurrentUser() async {
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = User.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future getCurrentUsernewUser() async {
    if (user.value.auth == null && _box.hasData('newUser')) {
      user.value = User.fromJson(await _box.read('newUser'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value = new User();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  Future isRoleChanged() async {
    try {
      var _user = await _usersRepo.getCurrentUser();
      if (_user.isProvider != user.value.isProvider) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.apiToken : '';
}
