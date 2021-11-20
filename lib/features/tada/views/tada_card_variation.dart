import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/tada/models/tadamodel.dart';
import 'package:new_ways_app/features/tada/views/show_approval_dialouge.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'tada_bottom_sheet.dart';

// ignore: must_be_immutable
class TadaUserList extends GetView {
  RxList<TadaModel> value;
  TadaUserList({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => (value.length == 0)
        ? Container(
            child: Center(
              child: Text('No Data Found'),
            ),
          )
        : ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) =>
                TadaUserCard(tadaModel: value[index]),
          ));
  }
}

class TadaUserCard extends StatelessWidget {
  final TadaModel tadaModel;

  TadaUserCard({
    required this.tadaModel,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          getTaDABottomSheet(deviceSize, tadaModel);
          print(
              '${tadaModel.data.department_head_aproval} :${tadaModel.data.boss_aproval} :${tadaModel.data.accounts_aproval} :${tadaModel.data.self_aproval} :');
        },
        onDoubleTap: () {
          if (tadaModel.data.bill_attachment != null &&
              tadaModel.data.bill_attachment != '') {
            print(tadaModel.data.bill_attachment!.split(',').length);
            Get.defaultDialog(
              title:
                  "TA DA Attachment Count : ${tadaModel.data.bill_attachment!.split(',').length}",
              content: Container(
                height: deviceSize.height * 0.7,
                width: deviceSize.width * 0.8,
                color: Colors.white,
                child: ListView.builder(
                    itemCount:
                        tadaModel.data.bill_attachment!.split(',').length,
                    itemBuilder: (context, index) => InteractiveViewer(
                          panEnabled: true,
                          child: Image.network(
                            '$baseImageUrl${tadaModel.data.bill_attachment!.split(',')[index]}',
                            width: deviceSize.width * 0.7,
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        )),
              ),
            );
          }
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
                  children: [
                    Text(tadaModel.user.full_name!, style: kTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            '$baseImageUrl${tadaModel.user.photo}'),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Total : ${int.parse((tadaModel.data.food_amount! == '') ? '0' : tadaModel.data.food_amount!) + int.parse((tadaModel.data.transport_amount == '') ? '0' : tadaModel.data.transport_amount!)}',
                        style: kTitleText.copyWith(color: Colors.red)),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tadaModel.data.transport_details!, style: kTitleText),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'From : ${tadaModel.data.destination_from!} \nTo: ${tadaModel.data.destination_to}',
                      style: kSubTitleText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Food Cost: ${tadaModel.data.food_amount} \nTransportation Cost : ${tadaModel.data.transport_amount!}',
                      style: kSubTitleText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date: ${tadaModel.data.transport_date}',
                      style: kSubTitleText,
                    ),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.3,
                child: (tadaModel.data.accounts_aproval == '1' &&
                        tadaModel.data.department_head_aproval == '1' &&
                        tadaModel.data.boss_aproval == '1' &&
                        tadaModel.data.self_aproval == '1')
                    ? Text(
                        'Approved',
                        style: kSubTitleText.copyWith(color: Colors.green),
                      )
                    : (tadaModel.data.accounts_aproval == '2' ||
                            tadaModel.data.department_head_aproval == '2' ||
                            tadaModel.data.boss_aproval == '2' ||
                            tadaModel.data.self_aproval == '2')
                        ? Text(
                            (tadaModel.data.department_head_aproval == '2')
                                ? 'Rejected By Department Head'
                                : (tadaModel.data.accounts_aproval == '2')
                                    ? 'Rejected By Accounts'
                                    : (tadaModel.data.boss_aproval == '2')
                                        ? 'Rejected By Boss'
                                        : 'Rejected By You',
                            style: kSubTitleText.copyWith(color: Colors.red),
                          )
                        : ((tadaModel.data.department_head_aproval == '0' ||
                                tadaModel.data.accounts_aproval == '0' ||
                                tadaModel.data.boss_aproval == '0'))
                            ? Text(
                                (tadaModel.data.department_head_aproval == '0')
                                    ? 'Pending Department Head Approval'
                                    : (tadaModel.data.boss_aproval == '0')
                                        ? 'Pending Boss Approval'
                                        : 'Pending Accounts Approval',
                                style: kSubTitleText.copyWith(
                                    color: Colors.orangeAccent),
                              )
                            : Container(
                                width: deviceSize.width * 0.2,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showTadaApprovalDialouge(
                                                tadaModel.data, '1');
                                          },
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showTadaApprovalDialouge(
                                                tadaModel.data, '2');
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
