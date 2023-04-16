import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_employee_controller.dart';

class MyEmployeeView extends GetView<MyEmployeeController> {
  const MyEmployeeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyEmployeeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MyEmployeeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
