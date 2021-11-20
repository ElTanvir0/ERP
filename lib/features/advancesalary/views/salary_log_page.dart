import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/advancesalary/controller/advance_salary_controller.dart';
import 'package:new_ways_app/features/advancesalary/views/advance_salary_request_page.dart';
import 'package:new_ways_app/features/advancesalary/views/widgets.dart';

class SalaryLogPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalaryController>(
      init: SalaryController(),
      initState: (_) {},
      builder: (_) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Salary Entry'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      _.getpastSalaries();
                      _.getUserAdvanceSalaryRequest();
                      _.getAdminAdvanceSalaryRequest();
                    },
                    icon: Icon(Icons.refresh)),
                IconButton(
                    onPressed: () {
                      Get.to(() => AdvanceSalaryRequestPage());
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
                    text: 'Advance Salary Request',
                  ),
                  Tab(
                    text: 'Past Salary Statement',
                  ),
                ],
              ),
            ),
            body: Obx(() => TabBarView(children: [
                  DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: Size(double.infinity, 50),
                        child: TabBar(
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.redAccent,
                              Colors.orangeAccent
                            ]),
                            color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.circular(10), // Creates border
                          ),
                          tabs: [
                            Tab(
                              text: 'Pending',
                            ),
                            Tab(
                              text: 'Approved',
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
                                      _.adminhive!.get('neways_boss_id')) ||
                                  (_.hive!.get('department') ==
                                      '2270968637477766714'))
                              ? DefaultTabController(
                                  length: 2,
                                  child: Scaffold(
                                    appBar: PreferredSize(
                                      preferredSize: Size(double.infinity, 50),
                                      child: TabBar(
                                        unselectedLabelColor: Colors.deepPurple,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicator: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Colors.deepPurple,
                                            Colors.purpleAccent
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
                                        AdvSalaryTableWidget(
                                            salaries: _.pendingAdvanceSalaries),
                                        AdvSalaryTableWidget(
                                            salaries: _.adminAdvanceSalaries)
                                      ],
                                    ),
                                  ),
                                )
                              : AdvSalaryTableWidget(
                                  salaries: _.pendingAdvanceSalaries),
                          AdvSalaryTableWidget(
                              salaries: _.acceptedAdvanceSalaries),
                          AdvSalaryTableWidget(
                              salaries: _.rejectedAdvanceSalaries),
                        ],
                      ),
                    ),
                  ),
                  SalaryTableWidget(
                    salaries: _.allSalaries,
                  ),
                ])),
          ),
        );
      },
    );
  }
}
