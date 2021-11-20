import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/tada/controller/ta_da_page_controller.dart';
import 'package:new_ways_app/features/tada/views/ta_da_page.dart';
import 'package:new_ways_app/features/tada/views/tada_card_variation.dart';

import 'tada_request_page.dart';

// ignore: must_be_immutable
class TadasPage extends GetView {
  UserController _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaDaPageController>(
      init: TaDaPageController(),
      initState: (_) {},
      builder: (_) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('TA/DA Page'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      _.getAllTaDa();
                      _.getAllUserData();
                    },
                    icon: Icon(Icons.refresh)),
                IconButton(
                    onPressed: () {
                      Get.to(() => TadaRequestPage());
                    },
                    icon: Icon(Icons.add))
              ],
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Creates border
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
                  child: (_userController.hive!.get('d_head') == '1' ||
                          _userController.hive!.get('department') ==
                              '2270968637477766714')
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
                                TadaUserList(
                                  value: _.userPendingTADA,
                                ),
                                TaDaPage(),
                              ],
                            ),
                          ),
                        )
                      : TadaUserList(
                          value: _.userPendingTADA,
                        ),
                ),
                TadaUserList(
                  value: _.userAcceptedTADA,
                ),
                TadaUserList(
                  value: _.userRejectedTADA,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
