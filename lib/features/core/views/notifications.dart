import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/views/notif_widgets.dart';

// ignore: must_be_immutable
class NotificationsPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NotificationList(),
      ),
    );
  }
}
