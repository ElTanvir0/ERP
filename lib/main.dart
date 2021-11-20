import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/services/background_service.dart';
import 'package:workmanager/workmanager.dart';
import 'features/core/views/splash_screen.dart';
import 'features/auth/controller/authentication_provider.dart';
import 'utils/constants.dart';

final androidConfig = FlutterBackgroundAndroidConfig(
  notificationTitle: "Neways3",
  notificationText: "Neways3 app running in the background",
  notificationImportance: AndroidNotificationImportance.Max,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FlutterBackground.initialize(androidConfig: androidConfig);
  await FlutterBackground.enableBackgroundExecution();
  Get.put(UserController());
  Get.put(AuthenticationController());
  AwesomeNotifications().initialize(
      'resource://drawable/res_splash_logo',
      [
        NotificationChannel(
            icon: 'resource://drawable/res_splash_logo',
            importance: NotificationImportance.Max,
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white),
        NotificationChannel(
          icon: 'resource://drawable/res_splash_logo',
          importance: NotificationImportance.Max,
          channelKey: 'high_intensity',
          channelName: 'High intensity notifications',
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          channelDescription:
              'Notification channel for notifications with high intensity',
        ),
      ],
      debug: true);

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Neways3',
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.light().copyWith(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
