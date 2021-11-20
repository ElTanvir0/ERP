import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/core/models/notif_count_model.dart';
import 'package:new_ways_app/features/core/models/notif_model.dart';
import 'package:new_ways_app/features/core/models/user_location_model.dart';
import 'package:new_ways_app/features/auth/models/user_model.dart';
import 'package:new_ways_app/features/core/models/version_model.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/services/notification_services.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:url_launcher/url_launcher.dart';

class UserController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  String? deviceID;
  dio.Dio _dio = dio.Dio();
  int notifCount = 0;
  StreamSubscription? streamSubscription;

  //For Notification
  RxList<NotifModel> notfications = <NotifModel>[].obs;
  RxString xen = ''.obs;

  Box? hive;
  Box? adminhive;

  String departmentHeadId = '';
  String currentUserBranchOperationHeadId = '';
  Rx<PageController> pageController = PageController().obs;

//Basic Functions
//==============================================================================================================================

  void clearalldata() {
    hive!.clear();
    adminhive!.clear();
  }

  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    deviceID = await PlatformDeviceId.getDeviceId;
    _dio = getDio();
  }

  fetchversion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    List<String> versions = packageInfo.version.split('.');
    try {
      dio.Response response = await _dio.get(
        '/version',
      );
      print(jsonDecode(response.data)[0]);
      VersionControl version =
          VersionControl.fromMap(jsonDecode(response.data)[0]);
      if (int.parse(version.state!) == 1) {
        if (int.parse(version.major!) <= int.parse(versions[0]) &&
            int.parse(version.minor!) <= int.parse(versions[1]) &&
            int.parse(version.patch!) <= int.parse(versions[2])) {
        } else {
          showToast('Please Update Your App');

          if (await canLaunch(version.link!)) {
            await launch(version.link!).then((value) {
              exit(0);
            });
          } else {
            showToast("Couldn't Open Update Link, Contact your Superior");
            exit(0);
          }
        }
      } else {
        showToast('App is Currently Under Maintenance');
        Future.delayed(Duration(seconds: 3)).then((value) {
          exit(0);
        });
      }
    } on dio.DioError catch (e) {
      print('fetchNotifications Error : ${e.message}');
    }

    print('${packageInfo.appName} : ${packageInfo.version}');
  }

//All About Notification
  subscribeToStream() async {
    String madToken = hive!.get('token');
    //Subscribe to Notification Stream
    dio.Response<dio.ResponseBody> rs;
    rs = await _dio.request('/notification',
        options: dio.Options(responseType: dio.ResponseType.stream));
    streamSubscription = rs.data!.stream.listen((event) {
      if (madToken == hive!.get('token')) {
        xen.value = utf8.decode(event);
        NotifCountModel ncount = NotifCountModel.fromMap(
            jsonDecode(xen.value.replaceAll('data: ', '')));
        print(
            'Count : ${ncount.count!} \nStart : $madToken \n  Now : ${hive!.get('token')}');
        if (int.parse(ncount.count!) != 0) {
          notifCount = notifCount + int.parse(ncount.count!);
          FlutterAppBadger.updateBadgeCount(notifCount);
          setNotification(
              title: 'New Notification',
              body: 'You Have ${ncount.count} Notifications');
          respondToNotification();
          fetchNotifications();
        }
      } else {
        if (streamSubscription != null) {
          streamSubscription!.cancel();
        }
      }
    });
  }

  Future<void> respondToNotification() async {
    try {
      dio.Response response = await _dio.post('/notification/pushed',
          data: {'time': DateFormat('y-M-d H:m:s').format(DateTime.now())},
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
      print(DateFormat('y-M-d H:m:s').format(DateTime.now()));
      print(response.statusCode);
    } on dio.DioError catch (e) {
      print('respondToNotification Error : ${e.message}');
    }
  }

  Future<dio.Response> readNotification(String id) async {
    notifCount = 0;
    FlutterAppBadger.removeBadge();
    dio.Response resp;
    try {
      resp = await _dio.post('/notification/read',
          data: {'id': id},
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
      print(resp.statusCode);
    } on dio.DioError catch (e) {
      resp = e.response!;
      print('respondToNotification Error : ${e.message}');
    }
    return resp;
  }

  fetchNotifications() async {
    List<NotifModel> _notifs = [];
    try {
      dio.Response response = await _dio.get(
        '/notification/show',
      );

      jsonDecode(response.data).forEach((element) {
        _notifs.add(NotifModel.fromMap(element));
      });
      notfications.value = _notifs.reversed.toList();
    } on dio.DioError catch (e) {
      print('fetchNotifications Error : ${e.message}');
    }
  }

  createNotification(
      {String? id,
      required String title,
      required String message,
      required String type,
      String? broadcast_scope,
      String? department}) async {
    print({
      'user_id': id ?? '',
      'header': title,
      'message': message,
      'type': type.toString(),
      'broadcast_scope': broadcast_scope ?? '',
      'department': department
    });
    await _dio.post('/notification/create',
        data: {
          'user_id': id ?? '',
          'header': title,
          'message': message,
          'type': type,
          'broadcast_scope': broadcast_scope ?? '',
          'department': department ?? ''
        },
        options:
            dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
  }

  UserController() {
    initializehive();
  }

  String getUploaderInfo() {
    print(
        '${hive!.get('role_name')}___${hive!.get('email')}___${hive!.get('branch')}');
    return '${hive!.get('role_name')}___${hive!.get('email')}___${hive!.get('branch')}';
  }

  String getDateString(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

//=================================================================================================================================

//Methods Related to Current User
//=================================================================================================================================
//Fetches Current User Data
  getUserData() async {
    String id = hive!.get('employee_id');
    print(' trying to user data : $id');
    if (id == '') {
      id = user.value.employee_id!;
    }

    try {
      dio.Response response = await _dio.get('/end-point-here');

      UserModel userModel = UserModel.fromMap(response.data[0]);
      print(response.data);
      if (response.statusCode == 200) {
        hive!.putAll(userModel.toMap());
      } else {
        print(
            'Testing from get user : ${response.statusCode} :${response.realUri}');
      }
      user.value = userModel;
      update();
    } on dio.DioError catch (e) {
      print('Testing from get user : ${e.type} :${e.message}');
    }
  }

//Send User Live Data to Server
  sendUserLiveLocationDataToServer(UserLocation userLocation) async {
    dio.Response response = await _dio.post('/end-point-here',
        data: userLocation.toMap(),
        options:
            dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
    if (response.statusCode == 201) {
      print('location data insertedSuccessfully');
    }
  }

//=================================================================================================================================

//Related To admin
//=================================================================================================================================
//Gets Boss ID
  Future<void> getReportingBossid() async {
    String dhead = hive!.get('d_head');
    String hid = hive!.get('d_head_reporting');
    String department = hive!.get('department');
    if (dhead == '1' &&
        (department != '2392358440567352112' ||
            department != '1810685559802248792')) {
      // ignore: unnecessary_null_comparison
      if (hid != null && hid != '') {
        try {
          dio.Response response = await _dio.get('/end-point-here');

          UserModel userModel = UserModel.fromMap(response.data[0]);

          adminhive!.put('neways_boss_id', userModel.employee_id);
          print('Boss : ${userModel.full_name}');
        } on dio.DioError catch (e) {
          print(e);
        }
      } else {
        if (department == '687558693128511379') {
          adminhive!.put('neways_boss_id', '00001');
        } else {
          adminhive!.put('neways_boss_id', '00002');
        }
      }
    }
  }

//=================================================================================================================================
// Method To get Department Head ID
  Future<void> getDepartmentHeadId() async {
    String departmentId = hive!.get('department');
    String branchId = hive!.get('branch');
    dio.Response? response;
    try {
      response = await _dio.get('/end-point-here');

      if (response.data.length == 0) {
        response = await _dio.get('/end-point-here');
      }

      UserModel departmentHead = UserModel.fromMap(response.data[0]);
      print('Calling From getDepartmentHeadId : ${response.data[0]} ');

      adminhive!.put('department_head_id', departmentHead.employee_id!);
      adminhive!.put('d_h_id', departmentHead.id!);
      print(
          '${adminhive!.get('department_head_id')} : ${adminhive!.get('d_h_id')}');
    } on dio.DioError catch (e) {
      print(e.message);
    }
  }

//=================================================================================================================================

  Future<String> getBranchOperationHeadIdOfASpecificBranch() async {
    var branchId = hive!.get('branch');
    print('Branch ID : $branchId');

    if (branchId != 'BAR_011220_210463187872898170_1606780607') {
      try {
        dio.Response _response = await _dio.get(
          '/end-point-here',
        );
        if (_response.statusCode == 200) {
          UserModel userModel = UserModel.fromMap(_response.data[0]);
          print('branchOperationHeadIdCurrent${userModel.employee_id}');
          currentUserBranchOperationHeadId = userModel.employee_id!;
          adminhive!.put('neways_branch_operationhead', userModel.employee_id);
          adminhive!.put('branch_h_id', userModel.id);
          print(
              'branchOperationHeadIdCurrent ${adminhive!.get('branch_h_id')}');
        } else {
          print('branchOperationHeadIdCurrent : ${_response.statusCode}');
        }
      } on dio.DioError catch (e) {
        print('Could not get Branch Head : $e');
      }
    }

    return currentUserBranchOperationHeadId;
  }
}
