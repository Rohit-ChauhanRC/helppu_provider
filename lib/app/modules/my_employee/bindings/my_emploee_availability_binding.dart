import 'package:get/get.dart';
import '../controllers/my_employee_availability_controller.dart';

class MyEmployeeAvailabilityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEmployeeAvailabilityFormController>(
      () => MyEmployeeAvailabilityFormController(),
    );
  }
}
