import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/models/userLeaveApprovalModel.dart';
import 'package:new_ways_app/features/leave/models/user_leave_model.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'leave_bottomsheet.dart';

// ignore: must_be_immutable
class LeaveRequstTableWidget extends StatelessWidget {
  RxList<UserLeaveModel> leaveProvider = <UserLeaveModel>[].obs;
  LeaveRequstTableWidget({Key? key, required this.leaveProvider})
      : super(key: key);
  LeaveController _leaveController = Get.find<LeaveController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
        child: (leaveProvider.length == 0)
            ? Center(
                child: Text('Nothing to show'),
              )
            : ListView.builder(
                itemCount: leaveProvider.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => LeaveHistoryListItem(
                      leaveModel: leaveProvider[index],
                    )),
        onRefresh: () => _leaveController.getLeaveHistory()));
  }
}

class LeaveHistoryListItem extends StatelessWidget {
  final UserLeaveModel leaveModel;
  LeaveHistoryListItem({Key? key, required this.leaveModel}) : super(key: key);
  final LeaveController _leaveController = Get.find<LeaveController>();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          print(leaveModel.id);
          getLeaveBottomSheet(
              deviceSize,
              UserLeaveApprovalModel(
                  id: leaveModel.id,
                  start_days: leaveModel.start_days,
                  end_date: leaveModel.end_date,
                  note: leaveModel.note));
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
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('From : ${leaveModel.start_days}',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('To : ${leaveModel.end_date}', style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Total: ${leaveModel.how_many_days} days',
                        style: kSubTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Reason: ${leaveModel.note}', style: kSubTitleText),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (leaveModel.h_aproval == '2' || leaveModel.aproval == '2')
                        ? Container(
                            width: deviceSize.width * 0.2,
                            child: Text('Rejected',
                                softWrap: true,
                                style: TextStyle(color: Colors.red)),
                          )
                        : ((leaveModel.h_aproval == '1' ||
                                    leaveModel.h_aproval == '3') &&
                                leaveModel.aproval == '1')
                            ? Text(
                                'Approved',
                                style: TextStyle(color: Colors.green),
                              )
                            : (leaveModel.h_aproval == '0' ||
                                    leaveModel.aproval == '0')
                                ? Container(
                                    width: deviceSize.width * 0.2,
                                    child: Text(
                                      (leaveModel.h_aproval == '0')
                                          ? 'Pending Depatment Head Approval'
                                          : 'Pending Boss Approval',
                                      softWrap: true,
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  )
                                : Text('Pending',
                                    style: TextStyle(color: Colors.amber)),
                    (leaveModel.h_aproval != '2' &&
                            (leaveModel.aproval != '1' ||
                                leaveModel.h_aproval != '1'))
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Remove Leave'),
                                        content: Text(
                                            'Do your really want to remove the leave?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                _leaveController
                                                    .removeLeaveRequest(
                                                        leaveModel);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'ok',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                        ],
                                      ));
                            },
                            icon: Icon(Icons.remove_circle_outline),
                            color: Colors.red,
                          )
                        : (leaveModel.h_aproval == '1' ||
                                leaveModel.h_aproval == '3' &&
                                    leaveModel.aproval == '1')
                            ? SizedBox()
                            : (leaveModel.h_aproval == '2' ||
                                    leaveModel.aproval == '2')
                                ? SizedBox()
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
