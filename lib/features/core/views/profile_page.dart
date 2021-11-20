import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ways_app/features/advancesalary/views/salary_log_page.dart';
import 'package:new_ways_app/features/attendence/views/all_attendence.dart';
import 'package:new_ways_app/features/car_rqusition/views/requisition_page.dart';
import 'package:new_ways_app/features/leave/views/leave_page.dart';
import 'package:new_ways_app/features/purchase_money_request/views/purchase_money_request_log_page.dart';
import 'package:new_ways_app/features/auth/views/log_in_page.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/resign/views/request_resign.dart';
import 'package:new_ways_app/features/tada/views/tadapage.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'dart:math' as math;

import 'sssss_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userCtrl = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    initprefs();
  }

  Future<void> initprefs() async {
    _userCtrl.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    //  final leaveHistoryProvider = context.watch<UserProvider>().leaveRequests;

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Container(
        child: (_userCtrl.hive!.get('full_name') == '')
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Flexible(
                      flex: 2,
                      child: UserPersonalInformationWidget(
                          deviceSize: deviceSize)),
                  SizedBox(
                    height: 8,
                  ),

                  Flexible(
                    flex: 6,
                    child: Container(
                      height: deviceSize.height * 0.5,
                      width: deviceSize.width * 0.9,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: [
                          ProfileSquare(
                            btnName: 'Leave',
                            iconData: Icon(Icons.airplane_ticket),
                            onClick: () {
                              Get.to(() => LeavesPage());
                            },
                          ),
                          ProfileSquare(
                            btnName: 'TA/DA',
                            iconData: Icon(Icons.request_quote),
                            onClick: () {
                              Get.to(() => TadasPage());
                            },
                          ),
                          ProfileSquare(
                            btnName: 'Purchase Money',
                            onClick: () {
                              Get.to(() => PurchaseMoneyRequestLogPage());
                            },
                            iconData: Icon(Icons.local_atm),
                          ),
                          ProfileSquare(
                            btnName: 'Salary',
                            onClick: () {
                              Get.to(() => SalaryLogPage());
                            },
                            iconData: Icon(Icons.payments),
                          ),
                          ProfileSquare(
                            btnName: 'Attendence',
                            onClick: () {
                              Get.to(() => AllAttendence());
                            },
                            iconData: Icon(Icons.domain),
                          ),
                          ProfileSquare(
                            btnName: 'Resign',
                            onClick: () {
                              Get.to(() => RequestResignPage());
                            },
                            iconData: Icon(
                              Icons.work_off,
                              color: Colors.red,
                            ),
                          ),
                          (_userCtrl.hive!.get('d_head') == '1' ||
                                  _userCtrl.hive!.get('designation') ==
                                      '1891238078957544400')
                              ? ProfileSquare(
                                  btnName: 'Car Requisition',
                                  onClick: () {
                                    Get.to(() => CarRequisitionPage());
                                  },
                                  iconData: Icon(Icons.car_rental))
                              : SizedBox(),
                          (_userCtrl.hive!.get('employee_id') == '71104')
                              ? ProfileSquare(
                                  btnName: 'SMENU',
                                  onClick: () {
                                    Get.to(() => SecretLocationMenu());
                                  },
                                  iconData: Icon(Icons.security),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  // LeaveRequestButton(

                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    flex: 2,
                    child: ProfileSquare(
                      btnName: 'Log Out',
                      onClick: () {
                        Get.off(() => LoginPage());
                        _userCtrl.clearalldata();
                        if (_userCtrl.streamSubscription != null) {
                          _userCtrl.streamSubscription!.cancel();
                        }
                      },
                      iconData: Icon(Icons.logout),
                    ),
                  ),
                  // : SizedBox(),
                ],
              ),
      ),
    );
  }
}

// ignore: must_be_immutable

class ProfileSquare extends StatelessWidget {
  const ProfileSquare({
    Key? key,
    required this.btnName,
    required this.onClick,
    required this.iconData,
  }) : super(key: key);
  final Widget iconData;
  final String btnName;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: deviceSize.width * 0.25,
          width: deviceSize.width * 0.25,
          decoration: getBoxDecoration.copyWith(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(flex: 1, child: iconData),
              Flexible(
                flex: 1,
                child: Text(
                  btnName,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveRequestButton extends StatelessWidget {
  LeaveRequestButton(
      {Key? key,
      required this.deviceSize,
      required this.btnName,
      required this.onClick})
      : super(key: key);

  final Size deviceSize;
  final String btnName;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width * 0.9,
      height: 45,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          btnName,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}

class UserPersonalInformationWidget extends StatelessWidget {
  UserPersonalInformationWidget({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;
  final _userctrl = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: deviceSize.width * 0.9,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              '$baseImageUrl${_userctrl.hive!.get('photo') ?? ''}'),
        ),
        title: Text(
          _userctrl.hive!.get('full_name') ?? '',
          style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '${_userctrl.hive!.get('designation_name') ?? ''} (${_userctrl.hive!.get('department_name') ?? ''})'),
      ),
    );
  }
}
