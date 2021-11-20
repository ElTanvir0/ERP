import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/purchase_money_request/controller/purchase_money_controller.dart';
import 'package:new_ways_app/features/purchase_money_request/models/purchase_money_request_model.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class PurchaseMoneyTableWidget extends StatelessWidget {
  RxList<PurchaseMoneyRequestModel> purchaseMoneyProvider =
      <PurchaseMoneyRequestModel>[].obs;
  PurchaseMoneyTableWidget({Key? key, required this.purchaseMoneyProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (purchaseMoneyProvider.length == 0)
        ? Center(
            child: Text('Nothing to show'),
          )
        : Padding(
            padding: EdgeInsets.all(0.0),
            child: Obx(() => ListView.builder(
                itemCount: purchaseMoneyProvider.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => PurchaseMoneyHistoryListItem(
                      purchaseMoneyRequestModel: purchaseMoneyProvider[index],
                    ))),
          );
  }
}

class PurchaseMoneyHistoryListItem extends StatelessWidget {
  final PurchaseMoneyRequestModel purchaseMoneyRequestModel;
  PurchaseMoneyHistoryListItem(
      {Key? key, required this.purchaseMoneyRequestModel})
      : super(key: key);
  final _purchaseMoneyController = Get.find<PurchaseMoneyController>();

  showApprovalDialouge(PurchaseMoneyRequestModel data, String approval) {
    bool isLoading = false;

    Get.defaultDialog(
      title: (approval == '2' || approval == '4')
          ? 'Accept Advance Money request?'
          : 'Deny Advance Money request?',
      middleText: (approval == '2' || approval == '4')
          ? 'You are about to Accept a Advance Money Request \nAre you sure about this?'
          : 'You are about to Deny a Advance Money Request \nAre you sure about this?',
      onCancel: () {},
      onConfirm: () async {
        if (isLoading != true) {
          isLoading = true;
          await _purchaseMoneyController.respondPurchaseMoneyrequest(
              data, approval);
          _purchaseMoneyController.onInit();
          isLoading = false;
          Get.back();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          print(purchaseMoneyRequestModel.id);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          '$baseImageUrl${purchaseMoneyRequestModel.photo!}'),
                    ),
                    getSpacer(),
                    Text(
                      purchaseMoneyRequestModel.designation_name!,
                      style: kSubTitleText.copyWith(fontSize: 12),
                    ),
                    Text(
                      purchaseMoneyRequestModel.department_name!,
                      style: kSubTitleText.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Name : ${purchaseMoneyRequestModel.full_name}',
                        style: kTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Amount : ${purchaseMoneyRequestModel.amount}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Reason: ${purchaseMoneyRequestModel.note}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Date: ${purchaseMoneyRequestModel.data}',
                        style: kSubTitleText),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (purchaseMoneyRequestModel.status == '3')
                        ? Container(
                            width: deviceSize.width * 0.2,
                            child: Text('Rejected',
                                softWrap: true,
                                style: TextStyle(color: Colors.red)),
                          )
                        : (purchaseMoneyRequestModel.status == '2')
                            ? Text(
                                'Approved',
                                style: TextStyle(color: Colors.green),
                              )
                            : (purchaseMoneyRequestModel.status == '1' &&
                                    _purchaseMoneyController.hive!
                                            .get('employee_id') ==
                                        _purchaseMoneyController.adminhive!
                                            .get('neways_boss_id'))
                                ? SizedBox()
                                : (purchaseMoneyRequestModel.status == '4' &&
                                        _purchaseMoneyController.hive!
                                                .get('employee_id') ==
                                            purchaseMoneyRequestModel
                                                .employee_id)
                                    ? SizedBox()
                                    : Text('Pending Boss Approval',
                                        style: TextStyle(color: Colors.amber)),
                    ((purchaseMoneyRequestModel.status == '1' &&
                                (_purchaseMoneyController.hive!
                                        .get('employee_id') ==
                                    _purchaseMoneyController.adminhive!
                                        .get('neways_boss_id'))) ||
                            (purchaseMoneyRequestModel.status == '4' &&
                                (_purchaseMoneyController.hive!
                                        .get('employee_id') ==
                                    purchaseMoneyRequestModel.employee_id)))
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showApprovalDialouge(
                                        purchaseMoneyRequestModel,
                                        (purchaseMoneyRequestModel.status ==
                                                '1')
                                            ? '4'
                                            : '2');
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showApprovalDialouge(
                                        purchaseMoneyRequestModel, '3');
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  )),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
