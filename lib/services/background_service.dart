import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/core/models/notif_count_model.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_services.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await Hive.initFlutter();
    } catch (e) {
      print(e);
    }
    Box hive = await Hive.openBox('dataBox');
    String madToken = hive.get('token');
    int notifCount = 0;

    dio.Dio _dio = getDio();

    // ignore: unused_local_variable
    StreamSubscription streamSubscription;
    dio.Response<dio.ResponseBody> rs;
    rs = await _dio.request('/notification',
        options: dio.Options(responseType: dio.ResponseType.stream));
    streamSubscription = rs.data!.stream.listen((event) {
      print(event);
      if (madToken == hive.get('token')) {
        String xen = utf8.decode(event);
        NotifCountModel ncount =
            NotifCountModel.fromMap(jsonDecode(xen.replaceAll('data: ', '')));
        if (int.parse(ncount.count!) == 0) {
          notifCount = notifCount + int.parse(ncount.count!);
          FlutterAppBadger.updateBadgeCount(notifCount);
          setNotification(
              title: 'New Notification',
              body: 'You Have ${ncount.count} Notifications');
          // respondToNotification();
          // fetchNotifications();
        }
      }
      // else {
      //   if (streamSubscription != null) {
      //     streamSubscription!.cancel();
      //   }
      // }
    });
    print('Tanvir BackgroundWorker');
    return Future.value(true);
  });
}
