import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/advancesalary/views/salary_log_page.dart';
import 'package:new_ways_app/features/car_rqusition/views/requisition_page.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/core/models/notif_model.dart';
import 'package:new_ways_app/features/leave/views/leave_page.dart';
import 'package:new_ways_app/features/purchase_money_request/views/purchase_money_request_log_page.dart';
import 'package:new_ways_app/features/tada/views/tadapage.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class NotificationList extends StatelessWidget {
  UserController _userController = Get.find<UserController>();

  NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_userController.notfications.length == 0)
          ? Center(
              child: Text('Nothing to show'),
            )
          : Padding(
              padding: EdgeInsets.all(0.0),
              child: ListView.builder(
                  itemCount: _userController.notfications.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => NotificationCard(
                        notifModel: _userController.notfications[index],
                      ))),
    );
  }
}

// ignore: must_be_immutable
class NotificationCard extends StatelessWidget {
  UserController _userController = Get.find<UserController>();
  final NotifModel notifModel;
  NotificationCard({Key? key, required this.notifModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    Duration ago =
        DateTime.now().difference(DateTime.parse(notifModel.creation_date!));
    String timeAgo = '';

    if (ago.inDays >= 1) {
      timeAgo = '${ago.inDays} day(s) ago';
    } else if (ago.inHours >= 1) {
      timeAgo = '${ago.inHours} hour(s) ago';
    } else if (ago.inMinutes >= 1) {
      timeAgo = '${ago.inMinutes} minute(s) ago';
    } else if (ago.inSeconds >= 1) {
      timeAgo = '${ago.inSeconds} second(s) ago';
    } else {
      timeAgo = 'just now';
    }
    Color txtColor = (notifModel.is_read == '0')
        ? Colors.white.withOpacity(0.8)
        : Colors.blueGrey.withOpacity(0.8);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          if (notifModel.is_read == '0') {
            _userController.readNotification(notifModel.id!).then((value) {
              if (value.statusCode == 200 || value.statusCode == 201) {
                _userController.fetchNotifications();
              }
            });
          }
          ;
          if (notifModel.n_header!.contains('Advance Salary')) {
            Get.to(SalaryLogPage());
          } else if (notifModel.n_header!.contains('Leave')) {
            Get.to(LeavesPage());
          } else if (notifModel.n_header!.contains('TA/DA')) {
            Get.to(TadasPage());
          } else if (notifModel.n_header!.contains('Purchase Money')) {
            Get.to(PurchaseMoneyRequestLogPage());
          } else if (notifModel.n_header!.contains('Car Requisition')) {
            Get.to(CarRequisitionPage());
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: getBoxDecoration.copyWith(
              color: (notifModel.is_read == '0')
                  ? Colors.blueGrey.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Type : ${notifModel.n_header!}',
                        style: kSubTitleText.copyWith(color: txtColor)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Message : ${notifModel.n_message!}',
                        style: kSubTitleText.copyWith(color: txtColor)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(timeAgo,
                        style: kSubTitleText.copyWith(color: txtColor)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
