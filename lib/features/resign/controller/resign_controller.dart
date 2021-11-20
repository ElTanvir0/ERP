import 'dart:convert';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/resign/models/resign_model.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class ResignController extends GetxController {
  dio.Dio _dio = getDio();
  Box? hive;
  Box? adminhive;
  RxList<ResignModel> resigns = <ResignModel>[].obs;

  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  approveResignRequest(String? id, String? note) async {
    try {
      await _dio
          .post('/resign-request/accept/$id',
              data: {'note': note},
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          showToast('Success..');
          Get.back();
        }
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  rjectResignRequest(String? id, String? note) async {
    try {
      await _dio
          .post('/resign-request/reject/$id',
              data: {'note': note},
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        print(value.statusCode);
        if (value.statusCode == 200) {
          showToast('Success..');
          Get.back();
        }
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  requestResign(String application) async {
    try {
      await _dio
          .post('/resign-request',
              data: {'application': application},
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        print(value.statusCode);
        if (value.statusCode == 201) {
          showToast('Request Successful..');
          Get.back();
        }
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  showResignrequest() async {
    List<ResignModel> _resigns = <ResignModel>[];
    resigns.value = <ResignModel>[];
    try {
      await _dio
          .get(
        '/resign-request/show',
      )
          .then((value) {
        if (value.statusCode == 200) {
          jsonDecode(value.data).forEach((element) {
            _resigns.add(ResignModel.fromMap(element));
          });
          print(_resigns.length);
          print(_resigns.first.application);
        }
      });

      resigns.value = _resigns;
    } on dio.DioError catch (e) {
      print(e);
    }
  }
}
