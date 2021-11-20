import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/core/views/main_page.dart';

setNotification({required String title, required String body}) {
  AwesomeNotifications().cancelAll();
  var rng = Random();
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: rng.nextInt(1000),
          channelKey: 'high_intensity',
          title: title,
          body: body));
}

addNotificationListener() {
  UserController _usercontroller = Get.find<UserController>();
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    if (!StringUtils.isNullOrEmpty(receivedNotification.buttonKeyInput)) {
      print('Cond 1');
    } else if (!StringUtils.isNullOrEmpty(
        receivedNotification.buttonKeyPressed)) {
      print('Cond 2');
    } else if (receivedNotification.channelKey == 'high_intensity') {
      Get.off(() => MainPage());
      _usercontroller.pageController.value.jumpToPage(1);
    }
  });
}
