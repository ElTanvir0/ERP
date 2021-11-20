import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/leave/views/widgets.dart';
import 'package:new_ways_app/features/leave/controller/leave_controller.dart';
import 'package:new_ways_app/features/leave/views/leave_request_page.dart';

import 'approval_page.dart';

// ignore: must_be_immutable
class LeavesPage extends GetView {
  UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveController>(
        init: LeaveController(),
        builder: (_) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Leave Page'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () async {
                          _.getLeaveHistory();
                          _.getLeaveRequstsForApproval();
                        },
                        icon: Icon(Icons.refresh)),
                    IconButton(
                        onPressed: () {
                          Get.to(() => LeaveRequestPage(
                              user: _userController.user.value));
                        },
                        icon: Icon(Icons.add))
                  ],
                  bottom: TabBar(
                    indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Creates border
                        color: Colors.greenAccent),
                    tabs: [
                      Tab(
                        text: 'Pending',
                      ),
                      Tab(
                        text: 'Accepted',
                      ),
                      Tab(
                        text: 'Rejected',
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Container(
                      child: (_userController.hive!.get('d_head') == '1')
                          ? DefaultTabController(
                              length: 2,
                              child: Scaffold(
                                appBar: PreferredSize(
                                  preferredSize: Size(double.infinity, 50),
                                  child: TabBar(
                                    unselectedLabelColor: Colors.redAccent,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.redAccent,
                                        Colors.orangeAccent
                                      ]),
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(
                                          10), // Creates border
                                    ),
                                    tabs: [
                                      Tab(
                                        text: 'Your Requests',
                                      ),
                                      Tab(
                                        text: 'Pending Your Approval',
                                      ),
                                    ],
                                  ),
                                ),
                                body: TabBarView(
                                  children: [
                                    Container(
                                      child: LeaveRequstTableWidget(
                                          leaveProvider:
                                              _.leaveRequestsPending),
                                    ),
                                    ApprovalPage(),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: LeaveRequstTableWidget(
                                  leaveProvider: _.leaveRequestsPending),
                            ),
                    ),
                    Container(
                      child: LeaveRequstTableWidget(
                        leaveProvider: _.leaveRequestsApproved,
                      ),
                    ),
                    Container(
                      child: LeaveRequstTableWidget(
                        leaveProvider: _.leaveRequestsRejected,
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
