import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';
import 'package:new_ways_app/features/car_rqusition/models/requsition_data_model.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'start_car_ride_dialouge.dart';

class CarScheduleForDriver extends GetView {
  final RxList<CarRequisitionModel> controller;

  CarScheduleForDriver(this.controller);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarRequsitionController>(
      init: CarRequsitionController(),
      builder: (_) {
        return Scaffold(
          body: Obx(() => (controller.length == 0)
              ? Container(
                  child: Center(
                    child: Text('No Data Found'),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.length,
                  itemBuilder: (context, index) =>
                      DriverSchedule(carRequisitionModel: controller[index]),
                )),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class DriverSchedule extends GetView {
  final CarRequisitionModel carRequisitionModel;
  CarRequsitionController _carRequsitionController =
      Get.find<CarRequsitionController>();

  DriverSchedule({required this.carRequisitionModel});
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
    }
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          if (carRequisitionModel.status == '2' &&
              DateTime.now()
                  .isBefore(DateTime.parse(carRequisitionModel.end_date!))) {
            print(
                '${DateTime.parse(carRequisitionModel.end_date!)} : ${DateTime.now()}');
            startCarRideDialouge(carRequisitionModel, 2);
          } else if (carRequisitionModel.status == '2' &&
              DateTime.now()
                  .isAfter(DateTime.parse(carRequisitionModel.end_date!))) {
            print('Got In boiiiiiiiiiiiiiiii');
            _carRequsitionController.respondtoCarRequest(
                carRequisitionModel: carRequisitionModel,
                note: "Didn't come in Time",
                status: '5');
          }
          if (carRequisitionModel.status == '3') {
            startCarRideDialouge(carRequisitionModel, 3);
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
