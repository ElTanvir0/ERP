import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/models/userLeaveApprovalModel.dart';
import 'package:new_ways_app/features/leave/views/leave_bottomsheet.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:new_ways_app/utils/shadow_container.dart';

import 'show_leave_approval_dialouge.dart';

class ApprovalPage extends StatelessWidget {
  ApprovalPage({Key? key}) : super(key: key);
  final userctr = Get.find<UserController>();
  final _leaveController = Get.find<LeaveController>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Obx(() => Scaffold(
        body: RefreshIndicator(
            child: (_leaveController.leaveRequestsForApproval.length == 0)
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('No approval requsst to show'),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Obx(() => ListView.builder(
                        itemCount:
                            _leaveController.leaveRequestsForApproval.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ApprovalListItem(
                              deviceSize: deviceSize,
                              user: _leaveController
                                  .leaveRequestsForApproval[index],
                            ))),
                  ),
            onRefresh: () => _leaveController.getLeaveRequstsForApproval())));
  }
}

// ignore: must_be_immutable
class ApprovalListItem extends StatefulWidget {
  UserLeaveApprovalModel user;
  Size deviceSize;
  ApprovalListItem({Key? key, required this.user, required this.deviceSize})
      : super(key: key);

  @override
  State<ApprovalListItem> createState() => _ApprovalListItemState();
}

class _ApprovalListItemState extends State<ApprovalListItem> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return ShadowContainer(
        offset: Offset(0, 3),
        shadowBlurRadius: 2,
        shadowRadius: 2,
        width: widget.deviceSize.width * 0.9,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: GestureDetector(
          onTap: () {
            print(widget.user.id);
            getLeaveBottomSheet(deviceSize, widget.user);
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage('$baseImageUrl${widget.user.photo}'),
            ),
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.user.full_name!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.user.start_days}-${widget.user.end_date}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'Reason : ${widget.user.note}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.check),
                  onPressed: () {
                    showLeaveApprovalDialouge('1', widget.user);
                  },
                ),
                IconButton(
                  onPressed: () {
                    showLeaveApprovalDialouge('2', widget.user);
                  },
                  icon: Icon(Icons.close),
                  color: Colors.red,
                )
              ],
            ),
          ),
        ));
  }
}
