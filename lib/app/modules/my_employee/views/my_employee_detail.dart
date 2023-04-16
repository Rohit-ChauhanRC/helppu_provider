import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../models/e_provider_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/media_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../e_providers/widgets/horizontal_stepper_widget.dart';
import '../../e_providers/widgets/step_widget.dart';
import '../../global_widgets/confirm_dialog.dart';
import '../../global_widgets/images_field_widget.dart';
import '../../global_widgets/multi_select_dialog.dart';
import '../../global_widgets/select_dialog.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/my_employee_detail_controller.dart';

class MyEmployeeDetailView extends GetView<MyEmployeeDetailController> {
  final controller =
      Get.put<MyEmployeeDetailController>(MyEmployeeDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return Text(
              controller.isCreateForm()
                  ? "Employee Add Service".tr
                  : controller.eProvider.value.name ?? '',
              style: context.textTheme.headline6,
            );
          }),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          actions: [
            if (!controller.isCreateForm())
              new IconButton(
                padding: EdgeInsets.symmetric(horizontal: 20),
                icon: new Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 28,
                ),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog(
                        title: "Delete Employee".tr,
                        content:
                            "Are you sure you want to delete this employee?".tr,
                        submitText: "Confirm".tr,
                        cancelText: "Cancel".tr,
                      );
                    },
                  );
                  if (confirm) {
                    //await controller.deleteEProvider();
                  }
                },
              ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  //onPressed: controller.eProvider.value.addresses.isEmpty
                  //    ? null
                  //    : () {
                  //        if (controller.isCreateForm()) {
                  //          controller.createEProviderForm();
                  //        } else {
                  //          controller.updateEProviderForm();
                  //        }
                  //      },
                  onPressed: () {
                    //Get.toNamed(Routes.MY_EMPLOYEE_AVAILABILITY,
                    //    arguments: {'eProvider': controller.eProvider});
                    controller.createEProviderForm();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary,
                  disabledElevation: 0,
                  disabledColor: Get.theme.focusColor,
                  child: Text("Save & Next".tr,
                      style: Get.textTheme.bodyText2
                          .merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.eProviderForm,
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
                Text("Employee details".tr, style: Get.textTheme.headline5)
                    .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                Text("Fill the following details and save them".tr,
                        style: Get.textTheme.caption)
                    .paddingSymmetric(horizontal: 22, vertical: 5),
                Obx(() {
                  return ImagesFieldWidget(
                    label: "Images".tr,
                    field: 'image',
                    tag: controller.eProviderForm.hashCode.toString(),
                    initialImages: controller.eProvider.value.images,
                    uploadCompleted: (uuid) {
                      controller.eProvider.update((val) {
                        val.images = val.images ?? [];
                        val.images.add(new Media(id: uuid));
                      });
                    },
                    reset: (uuids) {
                      controller.eProvider.update((val) {
                        val.images.clear();
                      });
                    },
                  );
                }),

                // employee

                //Container(
                //  padding:
                //      EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                //  margin:
                //      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                //  decoration: BoxDecoration(
                //      color: Get.theme.primaryColor,
                //      borderRadius: BorderRadius.all(Radius.circular(10)),
                //      boxShadow: [
                //        BoxShadow(
                //            color: Get.theme.focusColor.withOpacity(0.1),
                //            blurRadius: 10,
                //            offset: Offset(0, 5)),
                //      ],
                //      border: Border.all(
                //          color: Get.theme.focusColor.withOpacity(0.05))),
                //  child: Column(
                //    crossAxisAlignment: CrossAxisAlignment.stretch,
                //    children: [
                //      Row(
                //        children: [
                //          Expanded(
                //            child: Text(
                //              "Employees".tr,
                //              style: Get.textTheme.bodyText1,
                //              textAlign: TextAlign.start,
                //            ),
                //          ),
                //          MaterialButton(
                //            onPressed: () async {
                //              final selectedValues =
                //                  await showDialog<Set<User>>(
                //                context: context,
                //                builder: (BuildContext context) {
                //                  return MultiSelectDialog(
                //                    title: "Select Employees".tr,
                //                    submitText: "Submit".tr,
                //                    cancelText: "Cancel".tr,
                //                    items: controller
                //                        .getMultiSelectEmployeesItems(),
                //                    initialSelectedValues: controller.employees
                //                        .where(
                //                          (user) =>
                //                              controller
                //                                  .eProvider.value.employees
                //                                  ?.where((element) =>
                //                                      element.id == user.id)
                //                                  ?.isNotEmpty ??
                //                              false,
                //                        )
                //                        .toSet(),
                //                  );
                //                },
                //              );
                //              controller.eProvider.update((val) {
                //                val.employees = selectedValues?.toList();
                //                //controller.eProvider.value.numberOfEmployees =
                //                //    selectedValues?.toList()?.length.toString();
                //              });
                //            },
                //            shape: StadiumBorder(),
                //            color: Get.theme.colorScheme.secondary
                //                .withOpacity(0.1),
                //            child: Text("Select".tr,
                //                style: Get.textTheme.subtitle1),
                //            elevation: 0,
                //            hoverElevation: 0,
                //            focusElevation: 0,
                //            highlightElevation: 0,
                //          ),
                //        ],
                //      ),
                //      Obx(() {
                //        if (controller.eProvider.value?.employees?.isEmpty ??
                //            true) {
                //          return Padding(
                //            padding: EdgeInsets.symmetric(vertical: 20),
                //            child: Text(
                //              "Select Employees".tr,
                //              style: Get.textTheme.caption,
                //            ),
                //          );
                //        } else {
                //          return buildEmployees(controller.eProvider.value);
                //        }
                //      })
                //    ],
                //  ),
                //),

                // single employee
                Obx(() {
                  if (controller.employees.isEmpty)
                    return Container(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 10, left: 20, right: 20),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.05))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Select Employees".tr,
                                    style: Get.textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    final selectedValue =
                                        await showDialog<User>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SelectDialog(
                                          title: "Select Employees".tr,
                                          submitText: "Submit".tr,
                                          cancelText: "Cancel".tr,
                                          items: [],
                                          //initialSelectedValue:
                                          initialSelectedValue:
                                              controller.employees.where(
                                            (user) =>
                                                controller
                                                    .eProvider.value.employees
                                                    ?.where((element) =>
                                                        element.id == user.id)
                                                    ?.isNotEmpty ??
                                                false,
                                          ),
                                        );
                                      },
                                    );
                                    controller.eProvider.update((val) {
                                      val.employees = [selectedValue];
                                      //controller.eProvider.value.numberOfEmployees =
                                      //    selectedValues?.toList()?.length.toString();
                                    });
                                  },
                                  shape: StadiumBorder(),
                                  color: Get.theme.colorScheme.secondary
                                      .withOpacity(0.1),
                                  child: Text("Select".tr,
                                      style: Get.textTheme.subtitle1),
                                  elevation: 0,
                                  hoverElevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                ),
                              ],
                            ),
                            Obx(() {
                              if (controller.eProvider.value.employees ==
                                  null) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "Select category".tr,
                                    style: Get.textTheme.caption,
                                  ),
                                );
                              } else {
                                return buildServicesA(
                                    controller.eProvider.value.employees[0]);
                              }
                            })
                          ],
                        ));
                  else
                    return Container(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 10, left: 20, right: 20),
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: Get.theme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Get.theme.focusColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5)),
                          ],
                          border: Border.all(
                              color: Get.theme.focusColor.withOpacity(0.05))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Select Employee".tr,
                                  style: Get.textTheme.bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  final selectedValue = await showDialog<User>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SelectDialog(
                                        title: "Select Employee".tr,
                                        submitText: "Submit".tr,
                                        cancelText: "Cancel".tr,
                                        items: controller
                                            .getMultiSelectEmployeesItemsA(),
                                        initialSelectedValue:
                                            controller.employees.where(
                                          (user) =>
                                              controller
                                                  .eProvider.value.employees
                                                  ?.where((element) =>
                                                      element.id == user.id)
                                                  ?.isNotEmpty ??
                                              false,
                                        ),
                                      );
                                    },
                                  );
                                  controller.eProvider.update((val) {
                                    val.employees = [selectedValue];
                                    //controller.eProvider.value.numberOfEmployees =
                                    //    selectedValues?.toList()?.length.toString();
                                  });
                                },
                                shape: StadiumBorder(),
                                color: Get.theme.colorScheme.secondary
                                    .withOpacity(0.1),
                                child: Text("Select".tr,
                                    style: Get.textTheme.subtitle1),
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                              ),
                            ],
                          ),
                          Obx(() {
                            if (controller.eProvider.value.employees == null) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Select category".tr,
                                  style: Get.textTheme.caption,
                                ),
                              );
                            } else {
                              return buildServicesA(
                                  controller.eProvider.value.employees[0]);
                            }
                          })
                        ],
                      ),
                    );
                }),

                Container(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                      border: Border.all(
                          color: Get.theme.focusColor.withOpacity(0.05))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Services".tr,
                              style: Get.textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              final selectedValues =
                                  await showDialog<Set<EService>>(
                                context: context,
                                builder: (BuildContext context) {
                                  return MultiSelectDialog(
                                    title: "Select Services".tr,
                                    submitText: "Submit".tr,
                                    cancelText: "Cancel".tr,
                                    items: controller
                                        .getMultiSelectServicesItems(),
                                    initialSelectedValues: controller.eEService
                                        .where(
                                          (category) =>
                                              controller.eServiceA.value.id ==
                                                  category.id ??
                                              false,
                                        )
                                        .toSet(),
                                  );
                                },
                              );
                              //controller.eSelectService = selectedValues
                              //    ?.toList()
                              //    ?.map((((e) => e.id)))
                              //    ?.toList();
                              //controller.eServiceA.update((val) {
                              controller.eEServiceA.value =
                                  selectedValues?.toList();
                              //});
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary
                                .withOpacity(0.1),
                            child: Text("Select".tr,
                                style: Get.textTheme.subtitle1),
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                          ),
                        ],
                      ),
                      Obx(() {
                        if (controller.eEServiceA == null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "Select Services".tr,
                              style: Get.textTheme.caption,
                            ),
                          );
                        } else {
                          return buildServices(controller.eEServiceA.value);
                        }
                      })
                    ],
                  ),
                ),

                TextFieldWidget(
                  onChanged: (input) => controller.eProvider.value
                      .availabilityRange = double.tryParse(input) ?? 0,
                  validator: (input) => (double.tryParse(input) ?? 0) <= 0
                      ? "Should be more than 0".tr
                      : null,
                  initialValue: controller.eProvider.value.availabilityRange
                          ?.toString() ??
                      null,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  hintText: "5".tr,
                  labelText: "Availability Range".tr,
                  suffix: Text(Get.find<SettingsService>()
                      .setting
                      .value
                      .distanceUnit
                      .tr),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildEmployees(EProvider _eProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 8,
          children: List.generate(_eProvider.employees?.length ?? 0, (index) {
            final _user = _eProvider.employees.elementAt(index);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(_user.name,
                  style: Get.textTheme.bodyText1.merge(
                      TextStyle(color: Get.theme.colorScheme.secondary))),
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                  border: Border.all(
                    color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            );
          })),
    );
  }

  Widget buildTaxes(EProvider _eProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 8,
          children: List.generate(_eProvider.taxes?.length ?? 0, (index) {
            final tax = _eProvider.taxes.elementAt(index);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(tax.name,
                  style: Get.textTheme.bodyText1.merge(
                      TextStyle(color: Get.theme.colorScheme.secondary))),
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                  border: Border.all(
                    color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            );
          })),
    );
  }

  Widget buildCategories(EService _eService) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_eService.categories?.length ?? 0, (index) {
              var _category = _eService.categories.elementAt(index);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(_category.name,
                    style: Get.textTheme.bodyText1
                        .merge(TextStyle(color: _category.color))),
                decoration: BoxDecoration(
                    color: _category.color.withOpacity(0.2),
                    border: Border.all(
                      color: _category.color.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              );
            }) +
            List.generate(_eService.subCategories?.length ?? 0, (index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(_eService.subCategories.elementAt(index).name,
                    style: Get.textTheme.caption),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              );
            }),
      ),
    );
  }

  Widget buildServices(List<EService> _eService) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_eService?.length ?? 0, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(_eService.elementAt(index).name,
                style: Get.textTheme.caption),
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                border: Border.all(
                  color: Get.theme.focusColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        }),
      ),
    );
  }

  Widget buildProviderType(EProvider _eProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child:
            Text(_eProvider.type?.name ?? '', style: Get.textTheme.bodyText2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget buildServicesA(User _eProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(_eProvider?.name ?? '', style: Get.textTheme.bodyText2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
