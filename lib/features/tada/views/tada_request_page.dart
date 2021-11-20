import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/tada/controller/ta_da_page_controller.dart';
import 'package:new_ways_app/features/tada/models/tadaDatamodel.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: must_be_immutable
class TadaRequestPage extends StatefulWidget {
  TadaRequestPage({Key? key}) : super(key: key);

  @override
  State<TadaRequestPage> createState() => _TadaRequestPageState();
}

class _TadaRequestPageState extends State<TadaRequestPage> {
  UserController _userctrl = Get.find<UserController>();
  TaDaPageController _taDaPageController = Get.find<TaDaPageController>();
  List<String> _branches = [
    'Corporate Office',
    'Super Home 3',
    'Super Home 4',
    'Super Home 5',
    'Super Home 6',
    'Super Home 7',
    'Super Home 8',
    'Other'
  ];

  List<String> vehicletypes = [];
  RxList<String> _frombranches = <String>[].obs;

  RxList<String> _toBranch = <String>[].obs;
  RxBool _fromOther = false.obs;
  RxBool _toOther = false.obs;
  TaDaDataModel _taDaDataModel = TaDaDataModel();

  var fullDayStartDateController = TextEditingController();

  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _frombranches = _toBranch = _branches.obs;
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kTryBG,
        appBar: AppBar(
          title: Center(child: Text('TA DA Request')),
        ),
        body: Obx(
          () => FormBuilder(
            key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: deviceSize.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getSpacer(),
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
                                    _toBranch = _branches.obs;
                                    _fromOther.value = (value == 'Other');

                                    setState(() {
                                      print(_toBranch.length);
                                      if (value != 'Other') {
                                        _toBranch.remove(value);
                                      }

                                      print(_toBranch.length);
                                    });
                                  },
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'From'),
                                  name: 'destination_from',
                                  items: _frombranches.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              (_fromOther.value) ? getSpacer() : Container(),
                              (_fromOther.value)
                                  ? Container(
                                      width: deviceSize.width * 0.42,
                                      decoration: getBoxDecoration,
                                      child: FormBuilderTextField(
                                        validator: (value) {
                                          return nullValidator(value);
                                        },
                                        maxLines: 5,
                                        textInputAction: TextInputAction.next,
                                        name: 'destination_from_other',
                                        decoration: getInputDecoration.copyWith(
                                            hintText:
                                                'Enter Your Transportation Details....'),
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
                                child: FormBuilderDropdown(
                                  validator: (value) {
                                    return nullValidator(value);
                                  },
                                  onChanged: (value) {
                                    _toOther.value = (value == 'Other');
                                  },
                                  decoration: getInputDecoration.copyWith(
                                      hintText: 'To'),
                                  name: 'destination_to',
                                  items: _toBranch.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
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
                                        textInputAction: TextInputAction.next,
                                        name: 'destination_to_other',
                                        decoration: getInputDecoration.copyWith(
                                            hintText:
                                                'Enter Your Transportation Details....'),
                                      ))
                                  : Container(),
                            ],
                          ),
                        ],
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
                              lastDate: DateTime.now(),
                              inputType: InputType.date,
                              name: 'transport_date',
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
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Amount?'),
                              name: 'transport_amount',
                            ),
                          ),
                        ],
                      ),
                      getSpacer(),
                      Row(
                        children: [
                          Container(
                            width: deviceSize.width * 0.42,
                            decoration: getBoxDecoration,
                            child: FormBuilderDropdown(
                              validator: (value) {
                                return nullValidator(value);
                              },
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Tansportation Type'),
                              name: 'transport_type',
                              items: <String>['One Way', 'Two Way']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Food Amount?'),
                              name: 'food_amount',
                            ),
                          ),
                        ],
                      ),
                      getSpacer(),
                      Row(
                        children: [
                          Container(
                            width: deviceSize.width * 0.42,
                            decoration: getBoxDecoration,
                            child: FormBuilderTextField(
                              validator: (value) {
                                return nullValidator(value);
                              },
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Transportation Detail/Reason'),
                              maxLines: 5,
                              name: 'transport_details',
                            ),
                          ),
                          SizedBox(
                            width: deviceSize.width * 0.06,
                          ),
                          Container(
                              width: deviceSize.width * 0.42,
                              decoration: getBoxDecoration,
                              child: ChipsInput(
                                inputAction: TextInputAction.next,
                                decoration: getInputDecoration.copyWith(
                                    hintText: 'Vehicele Type'),
                                maxChips: 3,
                                findSuggestions: (String query) {
                                  if (query.length != 0) {
                                    var lowercaseQuery = query.toLowerCase();
                                    return <String>[
                                      'Bus',
                                      'Rickshaw',
                                      'CNG',
                                      'Pathao',
                                      'Ubar',
                                      'Van',
                                      'Truck'
                                    ].where((data) {
                                      return data
                                          .toLowerCase()
                                          .contains(query.toLowerCase());
                                    }).toList(growable: false)
                                      ..sort((a, b) => a
                                          .toLowerCase()
                                          .indexOf(lowercaseQuery)
                                          .compareTo(b
                                              .toLowerCase()
                                              .indexOf(lowercaseQuery)));
                                  } else {
                                    return const <String>[];
                                  }
                                },
                                onChanged: (data) {
                                  vehicletypes = data as List<String>;
                                  print(data);
                                },
                                chipBuilder: (context, state, data) {
                                  return InputChip(
                                    key: ObjectKey(data),
                                    label: Text(data as String),
                                    onDeleted: () => state.deleteChip(data),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  );
                                },
                                suggestionBuilder: (context, state, data) {
                                  return ListTile(
                                    key: ObjectKey(data),
                                    title: Text(data as String),
                                    onTap: () => state.selectSuggestion(data),
                                  );
                                },
                              )),
                        ],
                      ),
                      getSpacer(),
                      Row(
                        children: [
                          Container(
                            width: deviceSize.width * 0.42,
                            decoration: getBoxDecoration,
                            child: FormBuilderTextField(
                              textInputAction: TextInputAction.next,
                              maxLines: 5,
                              decoration:
                                  getInputDecoration.copyWith(hintText: 'Note'),
                              name: 'note',
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
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              decoration: getInputDecoration.copyWith(
                                  hintText: 'Vehicle Type Reason'),
                              name: 'vehicle_type_reason',
                            ),
                          ),
                        ],
                      ),
                      getSpacer(),
                      Container(
                        width: deviceSize.width * 0.9,
                        decoration: getBoxDecoration,
                        child: FormBuilderImagePicker(
                          decoration: getInputDecoration,
                          maxImages: 3,
                          name: 'bill_attachment',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String imageurl = '';
                          var now = DateTime.now();
                          String vehicle_Type = '';
                          vehicletypes.forEach((element) {
                            if (vehicle_Type == '') {
                              vehicle_Type = element;
                            } else {
                              vehicle_Type = '$vehicle_Type, $element';
                            }
                          });

                          if (_formkey.currentState!.saveAndValidate()) {
                            if (_formkey.currentState!
                                        .fields['bill_attachment']!.value !=
                                    null &&
                                _formkey.currentState!
                                        .fields['bill_attachment']!.value !=
                                    '') {
                              List files = _formkey.currentState!
                                  .fields['bill_attachment']!.value;

                              await Future.forEach(files, (element) async {
                                String imageLink = await _taDaPageController
                                    .uploadImage(element as File);
                                imageurl = (imageurl == '')
                                    ? imageLink
                                    : '$imageurl,$imageLink';
                              });
                            }
                            FormBuilderState? formdata = _formkey.currentState;
                            DateTime _transportDate =
                                formdata!.fields['transport_date']!.value;

                            _taDaDataModel = TaDaDataModel(
                              id: '',
                              e_db_id: _userctrl.hive!.get('id'),
                              employee_id: _userctrl.hive!.get('employee_id'),
                              department_head_id:
                                  _userctrl.adminhive!.get('d_h_id') ?? '',
                              destination_from: (formdata
                                          .fields['destination_from']!.value ==
                                      'Other')
                                  ? 'Other : ${formdata.fields['destination_from_other']!.value}'
                                  : formdata.fields['destination_from']!.value,
                              destination_to: (formdata
                                          .fields['destination_to']!.value ==
                                      'Other')
                                  ? 'Other : ${formdata.fields['destination_to_other']!.value}'
                                  : formdata.fields['destination_from']!.value,
                              transport_date:
                                  _userctrl.getDateString(_transportDate),
                              transport_type:
                                  formdata.fields['transport_type']!.value,
                              transport_details:
                                  formdata.fields['transport_details']!.value,
                              transport_amount:
                                  formdata.fields['transport_amount']!.value,
                              food_amount:
                                  formdata.fields['food_amount']!.value,
                              vehicle_type: vehicle_Type,
                              vehicle_type_reason:
                                  formdata.fields['vehicle_type_reason']!.value,
                              bill_attachment: imageurl,
                              note: formdata.fields['note']!.value,
                              status: '1',
                              department_head_aproval:
                                  (_userctrl.hive!.get('d_head') == '1')
                                      ? '1'
                                      : '0',
                              boss_aproval: '0',
                              accounts_aproval: '0',
                              self_aproval: '0',
                              uploader_info: _userctrl.getUploaderInfo(),
                              data: _userctrl.getDateString(now),
                            );
                            await _taDaPageController
                                .requestTada(_taDaDataModel);

                            print(_taDaDataModel.toMap());
                            print(imageurl);
                          }
                          ;
                        },
                        child: Container(
                          child: Center(child: Text('Submit')),
                          width: deviceSize.width * 0.9,
                          height: 50,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
