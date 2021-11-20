import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/tada/controller/ta_da_page_controller.dart';
import 'package:new_ways_app/features/tada/models/tadaDatamodel.dart';
import 'package:new_ways_app/utils/constants.dart';

showTadaApprovalDialouge(TaDaDataModel data, String approval) {
  TaDaPageController _tadaPageController = Get.find<TaDaPageController>();
  String finalNote = '';
  bool isLoading = false;
  final _noteForm = GlobalKey<FormState>();
  final _note = TextEditingController();

  Get.defaultDialog(
      title:
          (approval == '1') ? 'Approve TA/DA request?' : 'Deny TA/DA request?',
      middleText: (approval == '1')
          ? 'You are about to accept a TA/DA Request \nAre you sure about this?'
          : 'You are about to accept a TA/DA Request \nAre you sure about this?',
      onCancel: () {},
      onConfirm: () async {
        if (isLoading != true) {
          if (_noteForm.currentState!.validate()) {
            isLoading = true;
            // ignore: unnecessary_null_comparison
            if (_note.text != null) {
              finalNote = _note.text;
            }
            await _tadaPageController.respondTadaRequest(
                data, approval, finalNote);
            _tadaPageController.onInit();
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
