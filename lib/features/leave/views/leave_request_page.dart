import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/models/user_leave_model.dart';
import 'package:new_ways_app/features/auth/models/user_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'package:uuid/uuid.dart';

class LeaveRequestPage extends StatefulWidget {
  late final UserModel user;
  LeaveRequestPage({Key? key, required this.user}) : super(key: key);

  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  LeaveController _leaveController = Get.find<LeaveController>();
  UserController _userController = Get.find<UserController>();

  GlobalKey<FormBuilderState> _formBuilderKey = GlobalKey<FormBuilderState>();

  RxInt halfFullButtonIndex = 0.obs;
  RxInt adminselfButtonIndex = 0.obs;

  String selectedButton = 'Full Day';
  String adminSelectedButton = 'Full Day';

  List<DateTime> leaveDates = [];
  final _userCtrl = Get.find<UserController>();

  String? returnLeaveReasonValidationMessage(String? value) {
    if (value!.isEmpty) {
      return 'Please enter leave reason';
    }
    return null;
  }

  getpresentDate() {
    var presentDat = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(presentDat);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final headId = _userCtrl.hive!.get('d_head');

    return Obx(
      () => Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Request Leave'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
              ),
              Center(),
              FormBuilder(
                  key: _formBuilderKey,
                  child: Column(
                    children: [
                      (headId == '1')
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: deviceSize.width * 0.9,
                                child: Row(
                                  children: [
                                    ...['Self', 'Subordinate']
                                        .asMap()
                                        .entries
                                        .map((e) => GestureDetector(
                                              onTap: () {
                                                adminselfButtonIndex.value =
                                                    e.key;
                                                if (e.value == 'Self') {
                                                  adminSelectedButton = 'Self';
                                                }
                                                if (e.value == 'Subordinate') {
                                                  adminSelectedButton =
                                                      'Subordinate';
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: (e.key ==
                                                          adminselfButtonIndex
                                                              .value)
                                                      ? kPrimaryColor
                                                      : Colors.white
                                                          .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(4, 4),
                                                      blurRadius: 5,
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                    ),
                                                  ],
                                                ),
                                                height: 45,
                                                width: deviceSize.width * 0.45,
                                                child: Center(
                                                  child: Text(
                                                    e.value,
                                                    style: TextStyle(
                                                      color: (e.key ==
                                                              adminselfButtonIndex
                                                                  .value)
                                                          ? Colors.white
                                                          : kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      (adminSelectedButton == 'Subordinate')
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: deviceSize.width * 0.9,
                                decoration: getBoxDecoration,
                                child: FormBuilderDropdown(
                                  isExpanded: true,
                                  isDense: false,
                                  dropdownColor: kPrimaryColor.withOpacity(0.7),
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  validator:
                                      FormBuilderValidators.required(context),
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'Subordinate Name?'),
                                  name: 'subordinate',
                                  items: _leaveController.subordinates
                                      .map((UserModel value) {
                                    return DropdownMenuItem<UserModel>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          height: 50,
                                          decoration: getBoxDecoration,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '$baseImageUrl${value.photo}'),
                                              ),
                                              Text(value.full_name!)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: deviceSize.width * 0.9,
                          child: Row(
                            children: [
                              ...[
                                'Full Day',
                                'Half Day'
                              ].asMap().entries.map((e) => GestureDetector(
                                    onTap: () {
                                      halfFullButtonIndex.value = e.key;
                                      if (e.value == 'Half Day') {
                                        selectedButton = 'Half Day';
                                      }
                                      if (e.value == 'Full Day') {
                                        selectedButton = 'Full Day';
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            (e.key == halfFullButtonIndex.value)
                                                ? kPrimaryColor
                                                : Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(4, 4),
                                            blurRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      height: 45,
                                      width: deviceSize.width * 0.45,
                                      child: Center(
                                        child: Text(
                                          e.value,
                                          style: TextStyle(
                                            color: (e.key ==
                                                    halfFullButtonIndex.value)
                                                ? Colors.white
                                                : kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: deviceSize.width * 0.9,
                          decoration: getBoxDecoration,
                          child: FormBuilderTextField(
                            validator: FormBuilderValidators.required(context,
                                errorText: 'You Must Provide A valid Reason'),
                            name: 'reason',
                            decoration: getInputDecoration,
                          ),
                        ),
                      ),
                      Container(
                        width: deviceSize.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                width: deviceSize.width * 0.4,
                                decoration: getBoxDecoration,
                                child: FormBuilderDateTimePicker(
                                  validator: FormBuilderValidators.required(
                                      context,
                                      errorText: 'Please Select a Date'),
                                  inputType: InputType.date,
                                  name: 'start_date',
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'Leave Start Date'),
                                ),
                              ),
                            ),
                            (selectedButton == 'Full Day')
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      width: deviceSize.width * 0.4,
                                      decoration: getBoxDecoration,
                                      child: FormBuilderTextField(
                                        validator:
                                            FormBuilderValidators.required(
                                                context,
                                                errorText:
                                                    'Please provide a Value'),
                                        keyboardType: TextInputType.number,
                                        name: 'how_many_days',
                                        decoration: getInputDecoration.copyWith(
                                            hintText: 'How Many Days'),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: deviceSize.width * 0.4,
                                      decoration: getBoxDecoration,
                                      child: FormBuilderDropdown(
                                        validator:
                                            FormBuilderValidators.required(
                                                context),
                                        decoration: getInputDecoration.copyWith(
                                            hintText: 'When?'),
                                        name: 'when',
                                        items: ['Morning', 'Day']
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      getSpacer(),
                      Container(
                        height: 45,
                        width: deviceSize.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            var leaveId = Uuid().v4();
                            if (_formBuilderKey.currentState!
                                .saveAndValidate()) {
                              FormBuilderState? formdata =
                                  _formBuilderKey.currentState;
                              UserLeaveModel userLeaveModel = UserLeaveModel();
                              userLeaveModel.unique_id = leaveId;
                              userLeaveModel.e_db_id = (adminSelectedButton ==
                                      'Subordinate')
                                  ? formdata!.fields['subordinate']!.value.id
                                  : _leaveController.hive!.get('id');
                              userLeaveModel.employee_id =
                                  (adminSelectedButton == 'Subordinate')
                                      ? formdata!.fields['subordinate']!.value
                                          .employee_id
                                      : _leaveController.hive!
                                          .get('employee_id');

                              userLeaveModel.start_days =
                                  DateFormat('dd/MM/yyyy').format(
                                      formdata!.fields['start_date']!.value);
                              userLeaveModel.how_many_days =
                                  (selectedButton == 'Half Day')
                                      ? '0.5'
                                      : formdata.fields['how_many_days']!.value;

                              userLeaveModel.end_date =
                                  (selectedButton == 'Half Day')
                                      ? DateFormat('dd/MM/yyyy').format(
                                          formdata.fields['start_date']!.value)
                                      : DateFormat('dd/MM/yyyy').format(formdata
                                          .fields['start_date']!.value
                                          .add(Duration(
                                              days: (int.parse(formdata
                                                      .fields['how_many_days']!
                                                      .value) -
                                                  1))));

                              //hold Unhold
                              userLeaveModel.days = DateFormat('dd')
                                  .format(formdata.fields['start_date']!.value);
                              userLeaveModel.year = DateFormat('yyyy')
                                  .format(formdata.fields['start_date']!.value);
                              userLeaveModel.month = DateFormat('MM')
                                  .format(formdata.fields['start_date']!.value);

                              userLeaveModel.note = (selectedButton ==
                                      'Half Day')
                                  ? '${formdata.fields['reason']!.value} half (${formdata.fields['when']!.value})'
                                  : formdata.fields['reason']!.value;
                              if (_userCtrl.hive!.get('d_head') == '1') {
                                if ((_userCtrl.hive!.get('department') ==
                                        '2392358440567352112' ||
                                    _userCtrl.hive!.get('department') ==
                                        '1810685559802248792')) {
                                  userLeaveModel.h_aproval = '3';
                                } else {
                                  userLeaveModel.h_aproval = '1';
                                }
                              } else {
                                userLeaveModel.h_aproval = '0';
                              }

                              if (_userController.hive!.get('d_head') == '1' &&
                                  (_userCtrl.hive!.get('department') ==
                                          '2392358440567352112' ||
                                      _userCtrl.hive!.get('department') ==
                                          '1810685559802248792')) {
                                userLeaveModel.h_id = _userController.adminhive!
                                    .get('branch_h_id');
                                print('should be here');
                              } else {
                                userLeaveModel.h_id =
                                    _userController.adminhive!.get('d_h_id');
                              }
                              userLeaveModel.uploader_info =
                                  _userCtrl.getUploaderInfo();

                              userLeaveModel.data = getpresentDate();

                              if (selectedButton == 'Half Day') {
                                leaveDates
                                    .add(formdata.fields['start_date']!.value);

                                _leaveController
                                    .requestFullDayLeave(
                                        userLeaveModel, leaveDates)
                                    .then((_) {
                                  String currentUserDheadValue =
                                      _leaveController.hive!.get('d_head');
                                  String currentUserDepartmentID =
                                      _leaveController.hive!.get('department');
                                  _userController.createNotification(
                                      id: (currentUserDheadValue != '1')
                                          ? _leaveController.adminhive!
                                              .get('department_head_id')
                                          : (currentUserDepartmentID ==
                                                      '1810685559802248792' ||
                                                  currentUserDepartmentID ==
                                                      '2392358440567352112')
                                              ? _leaveController.adminhive!.get(
                                                  'neways_branch_operationhead')
                                              : _leaveController.adminhive!
                                                  .get('neways_boss_id'),
                                      title: 'Leave Request',
                                      message:
                                          '${(adminSelectedButton == 'Subordinate') ? formdata.fields['subordinate']!.value.full_name : _leaveController.hive!.get('full_name')} Requested Leave for ${userLeaveModel.how_many_days} day(s) starting from ${userLeaveModel.start_days}',
                                      type: 'personal');
                                  showToast('Leave request successfull');

                                  formdata.reset();
                                }).onError((error, stackTrace) {
                                  print('LeaveError: ${error.toString()}');
                                });

                                leaveDates = [];
                              }
                              if (selectedButton == 'Full Day') {
                                for (int i = 0;
                                    i <
                                        int.parse(formdata
                                            .fields['how_many_days']!.value);
                                    i++) {
                                  var date =
                                      formdata.fields['start_date']!.value;
                                  DateTime generatedDate = DateTime(
                                      date.year, date.month, date.day + i);
                                  leaveDates.add(generatedDate);
                                }

                                _leaveController
                                    .requestFullDayLeave(
                                  userLeaveModel,
                                  leaveDates,
                                )
                                    .then((response) {
                                  if (response.statusCode == 201) {
                                    String currentUserDheadValue =
                                        _leaveController.hive!.get('d_head');
                                    String currentUserDepartmentID =
                                        _leaveController.hive!
                                            .get('department');
                                    print('leveRequestSuccessfull general');
                                    // if (adminhive!.get('department_head_id') != null &&
                                    //     adminhive!.get('department_head_id') != '') {
                                    _userController.createNotification(
                                        id: (currentUserDheadValue != '1')
                                            ? _leaveController.adminhive!
                                                .get('department_head_id')
                                            : (currentUserDepartmentID ==
                                                        '1810685559802248792' ||
                                                    currentUserDepartmentID ==
                                                        '2392358440567352112')
                                                ? _leaveController.adminhive!.get(
                                                    'neways_branch_operationhead')
                                                : _leaveController.adminhive!
                                                    .get('neways_boss_id'),
                                        title: 'Leave Request',
                                        message:
                                            '${(adminSelectedButton == 'Subordinate') ? formdata.fields['subordinate']!.value.full_name : _leaveController.hive!.get('full_name')} Requested Leave for ${userLeaveModel.how_many_days} day(s) starting from ${userLeaveModel.start_days}',
                                        type: 'personal');
                                    showToast('Leave request successfull');
                                    print((adminSelectedButton == 'Subordinate')
                                        ? formdata.fields['subordinate']!.value
                                            .full_name
                                        : _leaveController.hive!
                                            .get('full_name'));
                                  }
                                  formdata.reset();
                                  Navigator.of(context).pop();
                                }).onError((error, stackTrace) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Error'),
                                            content: Text(error.toString()),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))
                                            ],
                                          ));
                                  print('LeaveError: ${error.toString()}');
                                  print('Stack: ${stackTrace.toString()}');
                                });

                                leaveDates = [];
                              }
                            }
                          },
                          child: Text(
                            'Request Leave',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
