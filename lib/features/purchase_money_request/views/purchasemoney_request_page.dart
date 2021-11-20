import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/purchase_money_request/controller/purchase_money_controller.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:loading_animations/loading_animations.dart';

// ignore: must_be_immutable
class PurchaseMoneyRequestPage extends GetView {
  GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  PurchaseMoneyController _purchaseMoneyController =
      Get.find<PurchaseMoneyController>();
  UserController _userController = Get.find<UserController>();

  RxBool _isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Purchase Money'),
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
                            await _purchaseMoneyController
                                .sendNewAdvanceMoneyRequest(
                                    amount: _formkey
                                        .currentState!.fields['amount']!.value,
                                    note: _formkey
                                        .currentState!.fields['reason']!.value)
                                .then((value) {
                              if (value.statusCode == 201) {
                                _userController.createNotification(
                                  id: _userController.adminhive!
                                      .get('neways_boss_id'),
                                  title: 'Purchase Money Request',
                                  type: 'personal',
                                  message:
                                      '${_userController.hive!.get('full_name')} has Requested Purchase Money of Amount ${_formkey.currentState!.fields['amount']!.value}৳',
                                );
                                showToast('Advance Money Request Successful');
                                _purchaseMoneyController.getAdminData();
                                _purchaseMoneyController.getallUserData();
                                Get.back();
                              }
                            });
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
