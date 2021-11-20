import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';

import 'package:new_ways_app/features/car_rqusition/models/requsition_data_model.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'car_requistion_dialouge.dart';

// ignore: must_be_immutable
class CarRequisitionList extends GetView {
  RxList<CarRequisitionModel> value;
  CarRequisitionList({
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
                CarRequisitionCard(carRequisitionModel: value[index]),
          ));
  }
}

// ignore: must_be_immutable
class CarRequisitionCard extends StatelessWidget {
  final CarRequisitionModel carRequisitionModel;
  CarRequsitionController _carRequsitionController =
      Get.find<CarRequsitionController>();

  CarRequisitionCard({required this.carRequisitionModel});
  Color background = Colors.white;
  Color text = Colors.black;
  String smessage = '';

  @override
  Widget build(BuildContext context) {
    if (carRequisitionModel.status == '0') {
      background = Colors.red;
      text = Colors.white;
      smessage = 'Rejected';
    } else if (carRequisitionModel.status == '1') {
      background = Colors.yellow;
      text = Colors.black;
      smessage = 'Pending';
    } else if (carRequisitionModel.status == '2') {
      background = Colors.teal;
      text = Colors.white;
      smessage = 'Accepted';
    } else if (carRequisitionModel.status == '3') {
      background = Colors.lightBlue;
      text = Colors.black;
      smessage = 'On Route';
    } else if (carRequisitionModel.status == '4') {
      background = Colors.green;
      text = Colors.black;
      smessage = 'Ended';
    } else if (carRequisitionModel.status == '5') {
      background = Colors.red;
      text = Colors.white;
      smessage = "Driver Rejected";
    }
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          if (_carRequsitionController.hive!.get('employee_id') ==
                  _carRequsitionController.adminhive!.get('neways_boss_id') &&
              carRequisitionModel.status == '1') {
            showCarRequisitionDialouge(carRequisitionModel);
          } else if (_carRequsitionController.hive!.get('employee_id') ==
                  carRequisitionModel.requisition_by &&
              DateTime.now()
                  .isBefore(DateTime.parse(carRequisitionModel.end_date!)) &&
              carRequisitionModel.status == '2') {
            Get.defaultDialog(
              title: 'Confirmation Code',
              content: Container(
                decoration: getBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    carRequisitionModel.confirmation_code ?? '',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              textCancel: 'Reject Ride',
              onCancel: () {
                _carRequsitionController.respondtoCarRequest(
                    carRequisitionModel: carRequisitionModel,
                    note: 'Self Reject',
                    status: '0');
              },
              textConfirm: 'Ok',
              onConfirm: () {
                Get.back();
              },
            );
          }

          // getTaDABottomSheet(deviceSize, tadaModel);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(carRequisitionModel.full_name!,
                        textAlign: TextAlign.center,
                        style: kTitleText.copyWith(color: text)),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            '$baseImageUrl${carRequisitionModel.photo}'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Note : ${carRequisitionModel.note!}',
                        style: kTitleText.copyWith(color: text)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'From: ${carRequisitionModel.destination_from!} \nTo : ${carRequisitionModel.destination_to!}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Starts: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(carRequisitionModel.start_date!))}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Ends: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(carRequisitionModel.end_date!))}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Car Name: ${carRequisitionModel.name}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Description : ${carRequisitionModel.description!}',
                      style: kSubTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Note: ${carRequisitionModel.approval_note}',
                      style: kTitleText.copyWith(color: text),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Status: ${smessage}',
                      style: kTitleText.copyWith(color: text),
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
