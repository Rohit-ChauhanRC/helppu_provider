import 'package:get/get.dart';

import '../controllers/my_employee_detail_controller.dart';

class MyEmployeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyEmployeeDetailController>(
      () => MyEmployeeDetailController(),
    );
  }
}
