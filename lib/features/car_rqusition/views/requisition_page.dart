import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/car_rqusition/controller/car_requisition_controller.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'car_schedule_for_driver.dart';
import 'request_car.dart';
import 'requisition_list_page.dart';

// ignore: must_be_immutable
class CarRequisitionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GetBuilder<CarRequsitionController>(
      init: CarRequsitionController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Car Requisition'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    (_.hive!.get('designation') == '1891238078957544400')
                        ? _.getDriverSchedules()
                        : _.getDateWiseRequistion();
                    (_.hive!.get('designation') == '1891238078957544400')
                        ? _.getDriverUpcomingRide()
                        : () {};
                  },
                  icon: Icon(Icons.refresh)),
              (_.hive!.get('d_head') == '1')
                  ? IconButton(
                      onPressed: () {
                        Get.to(() => RequestCar());
                      },
                      icon: Icon(Icons.add))
                  : SizedBox()
            ],
          ),
          body: (_.hive!.get('designation') == '1891238078957544400')
              ? Column(
                  children: [
                    getSpacer(),
                    Container(
                      width: deviceSize.width * 0.9,
                      decoration: getBoxDecoration,
                      child: FormBuilderDateTimePicker(
                        name: 'date',
                        inputType: InputType.date,
                        decoration: getInputDecoration.copyWith(
                            hintText: 'Pick A Date'),
                        onChanged: (value) {
                          if (value != null) {
                            _.driverselectedDate.value = value;
                            _.getDriverSchedules();
                          }
                        },
                      ),
                    ),
                    getSpacer(),
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
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
                                borderRadius:
                                    BorderRadius.circular(10), // Creates border
                              ),
                              tabs: [
                                Tab(
                                  text: 'Active',
                                ),
                                Tab(
                                  text: 'UpComing',
                                ),
                                Tab(
                                  text: 'Schedule',
                                ),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: [
                              CarScheduleForDriver(_.driverActiveRide),
                              CarScheduleForDriver(_.driverUpcomingRide),
                              CarScheduleForDriver(_.scheduledrequistions),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : ((_.hive!.get('employee_id') ==
                          _.adminhive!.get('neways_boss_id')) ||
                      (_.hive!.get('department') == '1383007286312996344'))
                  ? Column(
                      children: [
                        Container(
                          width: deviceSize.width * 0.9,
                          decoration: getBoxDecoration,
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            inputType: InputType.date,
                            decoration: getInputDecoration.copyWith(
                                hintText: 'Pick A Date'),
                            onChanged: (value) {
                              if (value != null) {
                                _.selectedDate.value = value;
                                _.getDateWiseRequistion();
                              }
                            },
                          ),
                        ),
                        getSpacer(),
                        Expanded(
                          child: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                              appBar: PreferredSize(
                                preferredSize: Size(double.infinity, 50),
                                child: TabBar(
                                  unselectedLabelColor: Colors.redAccent,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  isScrollable: true,
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
                                      text: 'Your Rides',
                                    ),
                                    Tab(
                                      text: 'All Rides',
                                    ),
                                    Tab(
                                      text: 'Needs Attention',
                                    ),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  CarRequisitionList(
                                    value: _.userRequistions,
                                  ),
                                  CarRequisitionList(
                                    value: _.requistions,
                                  ),
                                  CarRequisitionList(
                                    value: _.adminAttention,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          width: deviceSize.width * 0.9,
                          decoration: getBoxDecoration,
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            inputType: InputType.date,
                            decoration: getInputDecoration.copyWith(
                                hintText: 'Pick A Date'),
                            onChanged: (value) {
                              if (value != null) {
                                _.selectedDate.value = value;
                                _.getDateWiseRequistion();
                              }
                            },
                          ),
                        ),
                        getSpacer(),
                        Expanded(
                          child: DefaultTabController(
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
                                      text: 'Your Rides',
                                    ),
                                    Tab(
                                      text: 'All Rides',
                                    ),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                                children: [
                                  CarRequisitionList(
                                    value: _.userRequistions,
                                  ),
                                  CarRequisitionList(
                                    value: _.requistions,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
