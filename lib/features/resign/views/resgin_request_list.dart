import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/resign/controller/resign_controller.dart';
import 'package:new_ways_app/features/resign/models/resign_model.dart';
import 'package:new_ways_app/features/resign/views/resign_approval_dialouge.dart';
import 'package:new_ways_app/utils/constants.dart';

class ResignRequestList extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResignController>(
      init: ResignController(),
      builder: (_) {
        return Scaffold(
          body: Obx(() => (_.resigns.length == 0)
              ? Container(
                  child: Center(
                    child: Text('No Data Found'),
                  ),
                )
              : ListView.builder(
                  itemCount: _.resigns.length,
                  itemBuilder: (context, index) => ResignCard(_.resigns[index]),
                )),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ResignCard extends GetView {
  final ResignModel resignModel;

  ResignCard(this.resignModel);
  Color background = Colors.white;
  Color text = Colors.black;
  String smessage = '';

  @override
  Widget build(BuildContext context) {
    if (resignModel.aproval == '0') {
      background = Colors.yellow;
      text = Colors.black;
      smessage = 'Pending';
    } else if (resignModel.status == '1') {
      background = Colors.yellow;
      text = Colors.black;
      smessage = 'Pending';
    }
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onLongPress: () {
          Get.defaultDialog(
            title: 'Resign Application of ${resignModel.full_name}',
            content: Html(
              data: resignModel.application,
            ),
          );
        },
        onTap: () {
          showResignApprovalDialouge(resignModel);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: background.withOpacity(0.8),
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
                child: Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage('$baseImageUrl${resignModel.photo}'),
                  ),
                ),
              ),
              Container(
                width: deviceSize.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Name : ${resignModel.full_name!}',
                      style: kTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Apply Date: ${resignModel.data!}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
