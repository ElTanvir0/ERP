import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/auth/models/user_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/core/views/main_page.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class AuthenticationController extends GetxController {
  final _userctrl = Get.find<UserController>();

  dio.Dio _dio = getDio();
  UserModel? userModel;

  Future<dio.Response?>? loginViaQrCode(String value) async {
    dio.Response? response;
    try {
      response = await _dio.get(value);
      print('QR : $value');
    } on dio.DioError catch (e) {
      response = e.response;
    }
    return response;
  }

  Future<void> logingUser(
      String id, String password, BuildContext context) async {
    try {
      _userctrl.hive!.delete('token');
      dio.Response response = await _dio.post(
        '/login',
        data: dio.FormData.fromMap(
          {
            'employee_id': id,
            'password': password,
            'device_id': _userctrl.deviceID
          },
        ),
      );
      _userctrl.hive!.putAll(jsonDecode(response.data));
      _userctrl.hive!.put('employee_id', id);
      _userctrl.hive!.put('password', password);
      await _userctrl.getUserData();
      _userctrl.getDepartmentHeadId();
      _userctrl.getReportingBossid();
      _userctrl.getBranchOperationHeadIdOfASpecificBranch();
      Get.offAll(() => MainPage());
    } on dio.DioError catch (e) {
      Get.back();
      print(
          'Login Failure : ${e.response?.statusCode} : : ${e.response?.data}');
      Get.defaultDialog(
        title: 'Login Error',
        titleStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        middleText: (e.response != null)
            ? jsonDecode(e.response?.data)['message']
            : e.message,
        backgroundColor: kSecondaryColor,
      );
    }
  }
}
