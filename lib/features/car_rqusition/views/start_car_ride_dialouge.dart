import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';
import 'package:new_ways_app/features/car_rqusition/models/requsition_data_model.dart';
import 'package:new_ways_app/utils/constants.dart';

startCarRideDialouge(CarRequisitionModel carRequisitionModel, int code) {
  CarRequsitionController _carRequsitionController =
      Get.find<CarRequsitionController>();
  bool isLoading = false;
  final _noteForm = GlobalKey<FormBuilderState>();
  Get.bottomSheet(SingleChildScrollView(
    child: Container(
      decoration: getBoxDecoration,
      child: FormBuilder(
        key: _noteForm,
        child: Column(
          children: [
            getSpacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${(code == 2) ? 'Start' : 'End'} Ride?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            (code == 2)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: getBoxDecoration,
                      child: FormBuilderTextField(
                        validator: (value) {
                          return nullValidator(value);
                        },
                        keyboardType: TextInputType.number,
                        decoration: getInputDecoration.copyWith(
                            hintText: 'Confirmation Code?'),
                        name: 'confirmation_code',
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: getBoxDecoration,
                child: FormBuilderTextField(
                  validator: (value) {
                    return nullValidator(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration:
                      getInputDecoration.copyWith(hintText: 'Meter Reading?'),
                  name: 'mileage',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: getBoxDecoration,
                child: FormBuilderTextField(
                  decoration: getInputDecoration.copyWith(hintText: 'Note?'),
                  name: 'note',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (isLoading != true) {
                    if (_noteForm.currentState!.validate()) {
                      isLoading = true;
                      (code == 2)
                          ? _carRequsitionController.startRide(
                              carRequisitionModel: carRequisitionModel,
                              note: _noteForm
                                  .currentState!.fields['note']!.value!,
                              mileage: _noteForm
                                  .currentState!.fields['mileage']!.value!,
                              confirmation_code: _noteForm.currentState!
                                  .fields['confirmation_code']!.value!)
                          : _carRequsitionController.endRide(
                              carRequisitionModel: carRequisitionModel,
                              note: _noteForm
                                  .currentState!.fields['note']!.value!,
                              mileage: _noteForm
                                  .currentState!.fields['mileage']!.value!,
                            );
                      isLoading = false;
                      _carRequsitionController.getDriverUpcomingRide();
                      _carRequsitionController.getDriverSchedules();
                      Get.back();
                    }
                  }
                },
                child: Text('${(code == 2) ? 'Start' : 'End'}')),
          ],
        ),
      ),
    ),
  ));
}
