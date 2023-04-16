import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../e_providers/widgets/step_widget.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/my_employee_registration_controller.dart';
import '../../e_providers/widgets/horizontal_stepper_widget.dart';

class MyEmployeeRegistrationView
    extends GetView<MyEmployeeRegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Employee Registration".tr,
            style: context.textTheme.headline6,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () async {
              await Get.back();
            },
          ),
          elevation: 0,
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: Get.width,
                  child: BlockButtonWidget(
                    onPressed: () {
                      controller.register();
                      //Get.toNamed(Routes.MY_EMPLOYEE_DETAILS);
                    },
                    color: Get.theme.colorScheme.secondary,
                    text: Text(
                      "Save and Next".tr,
                      style: Get.textTheme.headline6
                          .merge(TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),
              ],
            ),
          ],
        ),
        body: Form(
          key: controller.registerFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizontalStepperWidget(
                  controller: new ScrollController(initialScrollOffset: 50),
                  steps: [
                    StepWidget(
                      title: Text(
                        "Addresses".tr,
                      ),
                      color: Get.theme.focusColor,
                      index: Text("1",
                          style: TextStyle(color: Get.theme.primaryColor)),
                    ),
                    StepWidget(
                      title: Text(
                        "Registration".tr,
                      ),
                      index: Text("2",
                          style: TextStyle(color: Get.theme.primaryColor)),
                    ),
                    StepWidget(
                      title: Text(
                        "Employee Details".tr,
                      ),
                      color: Get.theme.focusColor,
                      index: Text("3",
                          style: TextStyle(color: Get.theme.primaryColor)),
                    ),
                    StepWidget(
                      title: Text(
                        "Employee Availability".tr,
                      ),
                      color: Get.theme.focusColor,
                      index: Text("3",
                          style: TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ],
                ),
                Text("Registration Employee".tr, style: Get.textTheme.headline5)
                    .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                Text("Fill the following details and save them".tr,
                        style: Get.textTheme.caption)
                    .paddingSymmetric(horizontal: 22, vertical: 5),
                TextFieldWidget(
                  labelText: "Full Name".tr,
                  hintText: "John Doe".tr,
                  initialValue: controller.currentUser?.value?.name,
                  onChanged: (input) {
                    //debugPrint("${input}");
                    controller.currentUser?.value?.name = input;
                    debugPrint("${controller.name}");
                  },
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 characters".tr
                      : null,
                  iconData: Icons.person_outline,
                  isFirst: true,
                  isLast: false,
                ),
                TextFieldWidget(
                  labelText: "Email Address".tr,
                  hintText: "johndoe@gmail.com".tr,
                  initialValue: controller.currentUser?.value?.email,
                  onChanged: (input) =>
                      controller.currentUser?.value?.email = input,
                  validator: (input) => !input.contains('@')
                      ? "Should be a valid email".tr
                      : null,
                  iconData: Icons.alternate_email,
                  isFirst: false,
                  isLast: false,
                ),
                PhoneFieldWidget(
                  labelText: "Phone Number".tr,
                  hintText: "223 665 7896".tr,
                  initialCountryCode: controller.currentUser.value
                      .getPhoneNumber()
                      ?.countryISOCode,
                  initialValue:
                      controller.currentUser.value?.getPhoneNumber()?.number,
                  onChanged: (phone) {
                    return controller.currentUser.value.phoneNumber =
                        phone.completeNumber;
                  },
                  isLast: false,
                  isFirst: false,
                ),
                Obx(() {
                  return TextFieldWidget(
                    labelText: "Password".tr,
                    hintText: "••••••••••••".tr,
                    //initialValue: controller.currentUser?.password,
                    onChanged: (input) =>
                        controller.currentUser.value.password = input,
                    validator: (input) => input.length < 3
                        ? "Should be more than 3 characters".tr
                        : null,
                    obscureText: controller.hidePassword.value,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    isLast: true,
                    isFirst: false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value =
                            !controller.hidePassword.value;
                      },
                      color: Theme.of(context).focusColor,
                      icon: Icon(controller.hidePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
