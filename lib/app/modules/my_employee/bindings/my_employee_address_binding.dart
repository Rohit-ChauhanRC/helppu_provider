import 'package:get/get.dart';

import '../controllers/my_employee_address_controller.dart';
import '../controllers/my_employee_availability_controller.dart';
import '../controllers/my_employee_detail_controller.dart';
import '../controllers/my_employee_registration_controller.dart';

class MyEmployeeAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEmployeeAddressesFormController>(
      () => MyEmployeeAddressesFormController(),
    );
    Get.lazyPut<MyEmployeeAvailabilityFormController>(
      () => MyEmployeeAvailabilityFormController(),
    );
    Get.lazyPut<MyEmployeeDetailController>(
      () => MyEmployeeDetailController(),
    );
    Get.lazyPut<MyEmployeeRegistrationController>(
      () => MyEmployeeRegistrationController(),
    );
  }
}
