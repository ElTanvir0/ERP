import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';
import 'package:new_ways_app/features/car_rqusition/models/requsition_data_model.dart';
import 'package:new_ways_app/utils/constants.dart';

showCarRequisitionDialouge(CarRequisitionModel carRequisitionModel) {
  CarRequsitionController _carRequsitionController =
      Get.find<CarRequsitionController>();
  bool isLoading = false;
  final _noteForm = GlobalKey<FormBuilderState>();

  Get.defaultDialog(
      title: 'Respond to Car Request',
      middleText:
          'You are about to accept a Car Request \nAre you sure about this?',
      textConfirm: 'Accept',
      textCancel: 'Reject',
      onCancel: () {
        if (isLoading != true) {
          if (_noteForm.currentState!.validate()) {
            isLoading = true;
            _carRequsitionController.respondtoCarRequest(
                carRequisitionModel: carRequisitionModel,
                note: _noteForm.currentState!.fields['note']!.value!,
                status: '0');
            isLoading = false;
            _carRequsitionController.getDateWiseRequistion();
            Get.back();
          }
        }
      },
      onConfirm: () async {
        if (isLoading != true) {
          if (_noteForm.currentState!.validate()) {
            isLoading = true;
            _carRequsitionController.respondtoCarRequest(
                carRequisitionModel: carRequisitionModel,
                note: _noteForm.currentState!.fields['note']!.value!,
                status: '2');
            isLoading = false;
            _carRequsitionController.getDateWiseRequistion();
            Get.back();
          }
        }
      },
      content: FormBuilder(
        key: _noteForm,
        child: Container(
          decoration: getBoxDecoration,
          child: FormBuilderTextField(
            validator: (value) {
              return nullValidator(value);
            },
            decoration: getInputDecoration.copyWith(hintText: 'Note?'),
            name: 'note',
          ),
        ),
      ));
}
