import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/utils/constants.dart';

showAttendenceDialouge(DateTime datetime) {
  // AttendenceController _attendenceController = Get.find<AttendenceController>();
  // String finalNote = '';
  bool isLoading = false;
  final _noteForm = GlobalKey<FormState>();
  final _note = TextEditingController();

  Get.defaultDialog(
      title: 'Request Attendence',
      middleText: 'You are about to request Attendence Adjustment on Date?',
      onCancel: () {},
      onConfirm: () async {
        if (isLoading != true) {
          if (_noteForm.currentState!.validate()) {
            isLoading = true;
            // ignore: unnecessary_null_comparison
            if (_note.text != null) {
              // finalNote = _note.text;
            }
            isLoading = false;
            Get.back();
          }
        }
      },
      content: Form(
        key: _noteForm,
        child: TextFormField(
          decoration: getInputDecoration.copyWith(hintText: 'Note ?'),
          controller: _note,
          validator: (value) {
            return nullValidator(value);
          },
        ),
      ));
}
