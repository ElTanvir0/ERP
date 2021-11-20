import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/models/employee_leave_approval_table_model.dart';
import 'package:new_ways_app/features/leave/models/userLeaveApprovalModel.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'dart:math' as math;

getLeaveBottomSheet(Size deviceSize, UserLeaveApprovalModel user) {
  LeaveController _leaveController = Get.find<LeaveController>();
  Get.bottomSheet(Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: getBoxDecoration.copyWith(color: Colors.white),
      height: deviceSize.height * 0.6,
      child: Column(
        children: [
          SizedBox(
            height: deviceSize.height * 0.1,
            width: deviceSize.width - 20,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      '$baseImageUrl${user.photo ?? _leaveController.hive!.get('photo')}'),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.full_name ?? _leaveController.hive!.get('full_name'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    Text(
                      '${user.start_days}-${user.end_date}',
                    ),
                    SizedBox(
                      width: deviceSize.width * 0.6,
                      child: Text(
                        'Reason : ${user.note}',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceSize.height * 0.4,
            width: deviceSize.width - 20,
            child: FutureBuilder(
                future: _leaveController.getLeaveSpecificLogs(user.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<EmployeeLeaveApprovalTableModel> datas =
                        snapshot.data as List<EmployeeLeaveApprovalTableModel>;

                    if (datas.length == 0) {
                      return Center(
                        child: Text('No Respons Found'),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: getBoxDecoration.copyWith(
                                    color: Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(0.1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Response By : ${datas[index].uploaderInfo!.split('___')[1]}',
                                      ),
                                      Text(
                                        'Note : ${datas[index].approvalNote}',
                                      ),
                                      Text(
                                        'Approval Type : ${datas[index].approvalType}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    ),
  ));
}
