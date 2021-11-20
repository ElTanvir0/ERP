import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/advancesalary/controller/advance_salary_controller.dart';
import 'package:new_ways_app/features/advancesalary/models/salary_model.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:loading_animations/loading_animations.dart';

// ignore: must_be_immutable
class AdvanceSalaryRequestPage extends GetView {
  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  SalaryController _salaryController = Get.find<SalaryController>();
  SalaryModel? lastSalary;

  RxBool _isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Advance Salary'),
        centerTitle: true,
      ),
      body: Obx(
        () => LoadingOverlay(
          progressIndicator: LoadingBouncingGrid.circle(
            backgroundColor: kPrimaryColor,
            size: 100,
          ),
          isLoading: _isLoading.value,
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formkey,
              child: Center(
                child: Container(
                  width: deviceSize.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getSpacer(),
                      Container(
                        decoration: getBoxDecoration,
                        child: FormBuilderTextField(
                          validator: (value) {
                            return nullValidator(value);
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration:
                              getInputDecoration.copyWith(hintText: 'Amount?'),
                          name: 'amount',
                        ),
                      ),
                      getSpacer(),
                      Container(
                        decoration: getBoxDecoration,
                        child: FormBuilderTextField(
                          validator: (value) {
                            return nullValidator(value);
                          },
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration:
                              getInputDecoration.copyWith(hintText: 'Purpose?'),
                          name: 'reason',
                        ),
                      ),
                      getSpacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.saveAndValidate()) {
                            _isLoading.value = true;
                            await _salaryController.sendNewAdvanceSalaryRequest(
                                amount: _formkey
                                    .currentState!.fields['amount']!.value,
                                note: _formkey
                                    .currentState!.fields['reason']!.value);
                            _isLoading.value = false;
                          }
                          _isLoading.value = false;
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
