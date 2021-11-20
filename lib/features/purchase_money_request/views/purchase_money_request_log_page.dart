import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/purchase_money_request/controller/purchase_money_controller.dart';
import 'package:new_ways_app/features/purchase_money_request/views/widgets.dart';
import 'purchasemoney_request_page.dart';

class PurchaseMoneyRequestLogPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseMoneyController>(
      init: PurchaseMoneyController(),
      initState: (_) {},
      builder: (_) {
        return Obx(
          () => DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Advance Purchase Money'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        _.getallUserData();
                        _.getAdminData();
                      },
                      icon: Icon(Icons.refresh)),
                  IconButton(
                      onPressed: () {
                        Get.to(() => PurchaseMoneyRequestPage());
                      },
                      icon: Icon(Icons.add))
                ],
                bottom: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
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
                  ((_.hive!.get('employee_id') ==
                          _.adminhive!.get('neways_boss_id')))
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
                                (_.pendingPurchaseMoneyRequest.length != 0)
                                    ? PurchaseMoneyTableWidget(
                                        purchaseMoneyProvider:
                                            _.pendingPurchaseMoneyRequest)
                                    : Container(
                                        child: Center(
                                          child: Text('No Data Found'),
                                        ),
                                      ),
                                (_.adminPendingPurchaseMoneyRequest.length != 0)
                                    ? PurchaseMoneyTableWidget(
                                        purchaseMoneyProvider:
                                            _.adminPendingPurchaseMoneyRequest)
                                    : Container(
                                        child: Center(
                                          child: Text('No Data Found'),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        )
                      : ((_.pendingPurchaseMoneyRequest.length != 0)
                          ? PurchaseMoneyTableWidget(
                              purchaseMoneyProvider:
                                  _.pendingPurchaseMoneyRequest)
                          : Container(
                              child: Center(
                                child: Text('No Data Found'),
                              ),
                            )),
                  (_.acceptedPurchaseMoneyRequest.length != 0)
                      ? PurchaseMoneyTableWidget(
                          purchaseMoneyProvider: _.acceptedPurchaseMoneyRequest)
                      : Container(
                          child: Center(
                            child: Text('No Data Found'),
                          ),
                        ),
                  (_.rejectedPurchaseMoneyRequest.length != 0)
                      ? PurchaseMoneyTableWidget(
                          purchaseMoneyProvider: _.rejectedPurchaseMoneyRequest)
                      : Container(
                          child: Center(
                            child: Text('No Data Found'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Scaffold(
//           appBar: AppBar(
//             title: Text('Advance Purchase Money'),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Get.to(() => PurchaseMoneyRequestPage());
//                   },
//                   icon: Icon(Icons.add))
//             ],
//           ),
//           body: 