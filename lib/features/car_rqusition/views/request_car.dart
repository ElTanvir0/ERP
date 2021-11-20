import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';
import 'package:new_ways_app/features/car_rqusition/models/car_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/car_req_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/cr_branch_model.dart';
import 'package:new_ways_app/features/core/views/profile_page.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class RequestCar extends GetView {
  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  RxBool _fromOther = false.obs;
  RxBool _toOther = false.obs;
  RxBool _isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GetBuilder<CarRequsitionController>(
      init: CarRequsitionController(),
      builder: (_) => Scaffold(
        body: Obx(() => LoadingOverlay(
              isLoading: _isLoading.value,
              progressIndicator: LoadingBouncingGrid.circle(
                backgroundColor: kPrimaryColor,
                size: 100,
              ),
              child: FormBuilder(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: deviceSize.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: deviceSize.width * 0.42,
                                    decoration: getBoxDecoration,
                                    child: FormBuilderDropdown(
                                      validator: (value) {
                                        return nullValidator(value);
                                      },
                                      onChanged: (value) {
                                        _fromOther.value = (value == 'other');
                                      },
                                      decoration: getInputDecoration.copyWith(
                                          hintText: 'From'),
                                      name: 'destination_from',
                                      items: _.branchList
                                          .map((BranchModelCR value) {
                                        return DropdownMenuItem<String>(
                                          value: value.branch_name,
                                          child: Text(value.branch_name!),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  (_fromOther.value)
                                      ? getSpacer()
                                      : Container(),
                                  (_fromOther.value)
                                      ? Container(
                                          width: deviceSize.width * 0.42,
                                          decoration: getBoxDecoration,
                                          child: FormBuilderTextField(
                                            validator: (value) {
                                              return nullValidator(value);
                                            },
                                            maxLines: 5,
                                            textInputAction:
                                                TextInputAction.next,
                                            name: 'from_other',
                                            decoration:
                                                getInputDecoration.copyWith(
                                                    hintText:
                                                        'Ride Stats From?'),
                                          ))
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                width: deviceSize.width * 0.06,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: deviceSize.width * 0.42,
                                    decoration: getBoxDecoration,
                                    child: Obx(() => FormBuilderDropdown(
                                          validator: (value) {
                                            return nullValidator(value);
                                          },
                                          onChanged: (value) {
                                            _toOther.value = (value == 'other');
                                          },
                                          decoration: getInputDecoration
                                              .copyWith(hintText: 'To'),
                                          name: 'destination_to',
                                          items: _.branchList
                                              .map((BranchModelCR value) {
                                            return DropdownMenuItem<String>(
                                              value: value.branch_name,
                                              child: Text(value.branch_name!),
                                            );
                                          }).toList(),
                                        )),
                                  ),
                                  (_toOther.value) ? getSpacer() : Container(),
                                  (_toOther.value)
                                      ? Container(
                                          width: deviceSize.width * 0.42,
                                          decoration: getBoxDecoration,
                                          child: FormBuilderTextField(
                                            validator: (value) {
                                              return nullValidator(value);
                                            },
                                            maxLines: 5,
                                            textInputAction:
                                                TextInputAction.next,
                                            name: 'to_other',
                                            decoration:
                                                getInputDecoration.copyWith(
                                                    hintText: 'Ride Ends To?'),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                          getSpacer(),
                          Container(
                            width: deviceSize.width * 0.9,
                            decoration: getBoxDecoration,
                            child: FormBuilderDropdown(
                              validator: (value) {
                                return nullValidator(value);
                              },
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Select A Car'),
                              name: 'car_id',
                              items: _.carList.map((CarModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text('${value.name} - ${value.id}'),
                                );
                              }).toList(),
                            ),
                          ),
                          getSpacer(),
                          Row(
                            children: [
                              Container(
                                width: deviceSize.width * 0.42,
                                decoration: getBoxDecoration,
                                child: FormBuilderDateTimePicker(
                                  validator: (value) {
                                    return nullValidator(value);
                                  },
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  inputType: InputType.both,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute),
                                  name: 'from_time',
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'Transportation Date'),
                                ),
                              ),
                              SizedBox(
                                width: deviceSize.width * 0.06,
                              ),
                              Container(
                                width: deviceSize.width * 0.42,
                                decoration: getBoxDecoration,
                                child: FormBuilderTextField(
                                  validator: (value) {
                                    return nullValidator(value);
                                  },
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'Hours?'),
                                  name: 'requsition_duration',
                                ),
                              ),
                            ],
                          ),
                          getSpacer(),
                          Container(
                            width: deviceSize.width * 0.9,
                            decoration: getBoxDecoration,
                            child: FormBuilderTextField(
                              validator: (value) {
                                return nullValidator(value);
                              },
                              onChanged: (value) {
                                print(value);
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Note?'),
                              name: 'note',
                            ),
                          ),
                          getSpacer(),
                          ProfileSquare(
                              btnName: 'Request Car',
                              onClick: () {
                                if (_formkey.currentState!.saveAndValidate()) {
                                  _isLoading.value = true;
                                  FormBuilderState formdata =
                                      _formkey.currentState!;
                                  CarReqRequisitionModel _req =
                                      CarReqRequisitionModel(
                                    requisition_date: DateFormat('yyyy-MM-dd')
                                        .format(formdata
                                            .fields['from_time']!.value),
                                    from_time: DateFormat('HH:mm:ss').format(
                                        formdata.fields['from_time']!.value),
                                    requisition_duration: formdata
                                        .fields['requsition_duration']!.value,
                                    destination_from: formdata
                                        .fields['destination_from']!.value,
                                    destination_to: formdata
                                        .fields['destination_to']!.value,
                                    from_other: (formdata
                                                .fields['destination_from']!
                                                .value ==
                                            'other')
                                        ? formdata.fields['from_other']!.value
                                        : '',
                                    to_other: (formdata
                                                .fields['destination_to']!
                                                .value ==
                                            'other')
                                        ? formdata.fields['to_other']!.value
                                        : '',
                                    note: formdata.fields['note']!.value,
                                    car_id: formdata.fields['car_id']!.value,
                                  );

                                  _.requestCarRequisition(_req).then((value) {
                                    _isLoading.value = false;
                                    _formkey.currentState!.reset();
                                    _.getDateWiseRequistion();
                                    Get.back();
                                  });
                                }
                              },
                              iconData: Lottie.asset(
                                  'assets/car_travelling.json',
                                  fit: BoxFit.cover))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
