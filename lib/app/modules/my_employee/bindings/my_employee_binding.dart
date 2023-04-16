import 'package:get/get.dart';

import '../controllers/my_employee_controller.dart';

class MyEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEmployeeController>(
      () => MyEmployeeController(),
    );
  }
}
