import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:new_ways_app/features/attendence/controller/attendence_controller.dart';
import 'package:new_ways_app/features/attendence/models/attend_req_full_model.dart';
import 'package:new_ways_app/features/attendence/models/attend_req_single_model.dart';
import 'package:new_ways_app/features/core/views/profile_page.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class AttendenceRequest extends GetView {
  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  AttendenceController _attendenceController = Get.find<AttendenceController>();
  RxBool isLoading = false.obs;
  RxList<int> textList = <int>[0].obs;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Obx(() => LoadingOverlay(
          progressIndicator: LoadingBouncingGrid.circle(
            backgroundColor: kPrimaryColor,
            size: 100,
          ),
          isLoading: isLoading.value,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Request Attendence'),
              centerTitle: true,
            ),
            body: Container(
              height: deviceSize.height,
              child: FormBuilder(
                key: _formkey,
                child: ListView.builder(
                    itemCount: textList.length + 3,
                    itemBuilder: (context, index) {
                      if (index < textList.length) {
                        return ApprovalRequestWidget(
                          index: index,
                        );
                      } else if (index < textList.length + 1) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: deviceSize.width * 0.9,
                              decoration: getBoxDecoration,
                              child: FormBuilderTextField(
                                validator: (value) {
                                  return nullValidator(value);
                                },
                                name: 'note',
                                decoration: getInputDecoration.copyWith(
                                    hintText: 'Note'),
                              )),
                        );
                      } else if (index < textList.length + 2) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                decoration: getBoxDecoration,
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    textList.add(textList.length);
                                  },
                                ),
                              ),
                              (textList.length > 1)
                                  ? Container(
                                      width: 50,
                                      decoration: getBoxDecoration,
                                      child: IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          textList
                                              .removeAt(textList.length - 1);
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 50),
                          child: LeaveRequestButton(
                            btnName: 'Submit',
                            deviceSize: deviceSize,
                            onClick: () async {
                              if (_formkey.currentState!.saveAndValidate()) {
                                isLoading.value = true;
                                List<AttendenceReqSingleModel> datas = [];

                                for (var i = 0; i < textList.length; i++) {
                                  datas.add(AttendenceReqSingleModel(
                                    date: DateFormat('yyyy-MM-dd').format(
                                        _formkey.currentState!
                                            .fields['datepicker_$i']!.value),
                                    reason: _formkey.currentState!
                                        .fields['Reason_$i']!.value,
                                  ));
                                }
                                AttendReqFullModel attendReqFullModel =
                                    AttendReqFullModel(
                                        note: _formkey.currentState!
                                            .fields['note']!.value,
                                        requests: datas);
                                await _attendenceController
                                    .requestAttendence(attendReqFullModel);
                                isLoading.value = false;
                                print(attendReqFullModel.toJson());
                              }
                            },
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
        ));
  }
}

class ApprovalRequestWidget extends StatelessWidget {
  const ApprovalRequestWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: deviceSize.width * 0.4,
            decoration: getBoxDecoration,
            child: FormBuilderDateTimePicker(
                validator: (value) {
                  return nullValidator(value);
                },
                decoration: getInputDecoration.copyWith(hintText: 'Date?'),
                name: 'datepicker_${index}',
                inputType: InputType.date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now()),
          ),
          Container(
            width: deviceSize.width * 0.4,
            decoration: getBoxDecoration,
            child: FormBuilderDropdown(
              validator: (value) {
                return nullValidator(value);
              },
              decoration: getInputDecoration,
              name: 'Reason_${index}',
              items: ['Machine Issue', 'Forgot', 'Work Outside']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
