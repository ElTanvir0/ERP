import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/models/employee_leave_approval_table_model.dart';
import 'package:new_ways_app/features/leave/models/userLeaveApprovalModel.dart';
import 'package:new_ways_app/utils/constants.dart';

showLeaveApprovalDialouge(String approval, UserLeaveApprovalModel user) {
  LeaveController _leavecontroller = Get.find<LeaveController>();
  String finalNote = '';
  bool isLoading = false;
  final _noteForm = GlobalKey<FormState>();
  final _note = TextEditingController();

  Get.defaultDialog(
      title:
          (approval == '1') ? 'Approve Leave request?' : 'Deny Leave request?',
      middleText: (approval == '1')
          ? 'You are about to accept a Leave Request \nAre you sure about this?'
          : 'You are about to accept a Leave Request \nAre you sure about this?',
      onCancel: () {},
      onConfirm: () {
        if (isLoading != true) {
          if (_noteForm.currentState!.validate()) {
            isLoading = true;
            // ignore: unnecessary_null_comparison
            if (_note.text != null) {
              finalNote = _note.text;
            }
            if (approval == '1') {
              _leavecontroller.acceptLeaveRequest(user);

              EmployeeLeaveApprovalTableModel approval =
                  EmployeeLeaveApprovalTableModel.fromApprovalModel(user)
                      .copyWith(approvalNote: finalNote);

              _leavecontroller.insertDataToEmployeeLeaveApprovalTable(approval);
            } else if (approval == '2') {
              _leavecontroller.rejectLeaveRequest(
                user.id!,
              );

              EmployeeLeaveApprovalTableModel approval =
                  EmployeeLeaveApprovalTableModel.fromApprovalModel(user)
                      .copyWith(
                          approvalType: 'Rejected', approvalNote: finalNote);
              _leavecontroller.insertDataToEmployeeLeaveApprovalTable(approval);
            }

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
            if (value == null) {
              return null;
            } else if (value.contains('#')) {
              return '# can Not be Used';
            } else {
              return null;
            }
          },
        ),
      ));
}
