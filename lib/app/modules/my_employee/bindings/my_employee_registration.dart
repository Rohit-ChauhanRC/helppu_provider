import 'package:get/get.dart';

import '../controllers/my_employee_registration_controller.dart';

class MyEmployeeRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEmployeeRegistrationController>(
      () => MyEmployeeRegistrationController(),
    );
  }
}
