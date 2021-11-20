import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/resign/controller/resign_controller.dart';
import 'package:new_ways_app/features/resign/models/resign_model.dart';
import 'package:new_ways_app/utils/constants.dart';

showResignApprovalDialouge(ResignModel resignModel) {
  bool isLoading = false;
  final _noteForm = GlobalKey<FormBuilderState>();
  ResignController _resignController = Get.find<ResignController>();

  Get.defaultDialog(
      title: "Respond to ${resignModel.full_name}'s Resign Request",
      textConfirm: 'Accept',
      textCancel: 'Reject',
      confirmTextColor: Colors.black,
      onCancel: () async {
        if (isLoading != true) {
          if (_noteForm.currentState!.saveAndValidate()) {
            isLoading = true;
            await _resignController.rjectResignRequest(
              resignModel.id,
              _noteForm.currentState!.fields['note']!.value!,
            );
            isLoading = false;
            _resignController.showResignrequest();
            // Get.back();
          }
        }
      },
      onConfirm: () async {
        if (isLoading != true) {
          if (_noteForm.currentState!.saveAndValidate()) {
            isLoading = true;
            await _resignController.approveResignRequest(
              resignModel.id,
              _noteForm.currentState!.fields['note']!.value!,
            );
            isLoading = false;
            _resignController.showResignrequest();
            // Get.back();
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
