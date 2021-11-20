import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import 'package:new_ways_app/features/attendence/controller/attendence_controller.dart';
import 'package:new_ways_app/features/attendence/models/attendence_model.dart';
import 'package:new_ways_app/features/core/views/profile_page.dart';
import 'package:new_ways_app/utils/constants.dart';

import 'attendence_approval.dart';

// ignore: must_be_immutable
class AllAttendence extends GetView {
  List<AttendenceModel> days = <AttendenceModel>[];
  RxInt count = 0.obs;
  DateTime? usableDate;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GetBuilder<AttendenceController>(
        init: AttendenceController(),
        initState: (_) {},
        builder: (_) {
          print('Got Rebuild');
          return SafeArea(
            child: Obx(
              () => Scaffold(
                appBar: AppBar(
                  title: Text('Attendence'),
                  centerTitle: true,
                  actions: [
                    (_.hive!.get('department') == '1383007286312996344' ||
                            _.adminhive!.get('neways_boss_id') ==
                                _.hive!.get('employee_id'))
                        ? IconButton(
                            onPressed: () {
                              showToast('This Feature is Coming Soon');
                            },
                            icon: Icon(Icons.admin_panel_settings))
                        : SizedBox(),
                    IconButton(
                        onPressed: () {
                          Get.to(() => AttendenceRequest());
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                body: Column(
                  children: [
                    getSpacer(),
                    LeaveRequestButton(
                      btnName: (usableDate == null)
                          ? 'Choose a Month'
                          : '${getMonthName(usableDate!.month)} - ${usableDate!.year}',
                      onClick: () async {
                        days.clear();
                        DateTime date = (await showMonthPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now()))!;
                        // ignore: unnecessary_null_comparison
                        if (date != null) {
                          usableDate = date;
                          _.totalAttendence.forEach((element) {
                            if (int.parse('20${element.years!}') == date.year &&
                                int.parse(element.month!) == date.month) {
                              print('got Valid Value');
                              days.add(element);
                            }
                          });
                          count.value = getDaysinAmonth(
                              year: date.year, month: date.month);
                          print(getDayName(date));
                          print(days.length);
                        }
                      },
                      deviceSize: deviceSize,
                    ),
                    getSpacer(),
                    Expanded(
                        child: LiveGrid(
                      padding: EdgeInsets.all(16),
                      showItemInterval: Duration(milliseconds: 50),
                      showItemDuration: Duration(milliseconds: 150),
                      visibleFraction: 0.001,
                      itemCount: count.value,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder:
                          animationItemBuilder((index) => HorizontalItem(
                                attendenceOftheMonth: days,
                                date: DateTime(usableDate!.year,
                                    usableDate!.month, index + 1),
                              )),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class HorizontalItem extends StatelessWidget {
  final List<AttendenceModel> attendenceOftheMonth;

  bool isPresent() {
    bool result = false;
    attendenceOftheMonth.forEach((element) {
      if (int.parse(element.days!) == date.day && element.attendance == '1') {
        result = true;
      }
    });
    return result;
  }

  bool isnotUploaded() {
    print(date.day);

    int currentDay = DateTime.now().day;
    int uploadDay = 1;
    if (currentDay > 21) {
      uploadDay = 21;
    } else if (currentDay > 11) {
      uploadDay = 11;
    } else {
      uploadDay = 1;
    }
    if (date.day <= DateTime.now().day) {
      if (date.day >= uploadDay) {
        return true;
      } else
        return false;
    } else
      return true;
  }

  final DateTime date;
  HorizontalItem({
    Key? key,
    required this.date,
    required this.attendenceOftheMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          // if (!isPresent()) {
          //   if (date.month >= DateTime.now().month) {
          //     if (!isnotUploaded()) {
          //       showAttendenceDialouge(date);
          //     }
          //   } else {
          //     showAttendenceDialouge(date);
          //   }
          // }
          showToast('This Feature is Coming Soon');
        },
        child: Container(
          width: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Material(
              color: isPresent()
                  ? Colors.green
                  : (date.month >= DateTime.now().month)
                      ? isnotUploaded()
                          ? Colors.white
                          : Colors.red
                      : Colors.red,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${date.day}/${date.month}/${date.year}'),
                    Text(getDayName(date)),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );
