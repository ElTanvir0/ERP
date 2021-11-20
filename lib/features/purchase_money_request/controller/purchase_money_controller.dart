import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/purchase_money_request/models/purchase_money_request_model.dart';

import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class PurchaseMoneyController extends GetxController {
  RxList<PurchaseMoneyRequestModel> acceptedPurchaseMoneyRequest =
      <PurchaseMoneyRequestModel>[].obs;
  RxList<PurchaseMoneyRequestModel> rejectedPurchaseMoneyRequest =
      <PurchaseMoneyRequestModel>[].obs;
  RxList<PurchaseMoneyRequestModel> pendingPurchaseMoneyRequest =
      <PurchaseMoneyRequestModel>[].obs;
  RxList<PurchaseMoneyRequestModel> adminPendingPurchaseMoneyRequest =
      <PurchaseMoneyRequestModel>[].obs;
  dio.Dio _dio = getDio();
  UserController _userController = Get.find<UserController>();
  Box? hive;
  Box? adminhive;
  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    await getallUserData();
    await getAdminData();
  }

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  Future<dio.Response> sendNewAdvanceMoneyRequest(
      {required String amount, required String note}) async {
    dio.Response? response;
    DateTime dateTime = DateTime.now();
    Map<String, dynamic> data = {
      'id': '',
      'employee_id': hive!.get('employee_id'),
      'amount': amount,
      'note': note,
      'status': '1',
      'uploader_info':
          '${hive!.get('role_name')}___${hive!.get('email')}___${hive!.get('branch')}',
      'data': '${dateTime.day}/${dateTime.month}/${dateTime.year}'
    };
    try {
      response = await _dio.post('/end-point-here',
          data: data,
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
    } on dio.DioError catch (e) {
      print(e);
    }
    return response!;
  }

  Future<void> respondPurchaseMoneyrequest(
      PurchaseMoneyRequestModel data, String approval) async {
    try {
      await _dio
          .post('/end-point-here',
              data: {'status': approval},
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          _userController.createNotification(
              type: 'personal',
              id: data.employee_id!,
              title: 'Purchase Money Request Accepted',
              message:
                  'Boss has Approved Your Purchase Money Request of amount ${data.amount}৳');
        }
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  getallUserData() async {
    acceptedPurchaseMoneyRequest.clear();
    pendingPurchaseMoneyRequest.clear();
    rejectedPurchaseMoneyRequest.clear();
    List<PurchaseMoneyRequestModel> requests = [];
    try {
      dio.Response response = await _dio.get('/end-point-here');

      if (response.statusCode == 200) {
        response.data.forEach((element) {
          requests.add(PurchaseMoneyRequestModel.fromMap(element));
        });
        requests = requests.reversed.toList();
        print(response.data);

        requests.forEach((element) {
          if (element.status == '1' || element.status == '4') {
            pendingPurchaseMoneyRequest.add(element);
          } else if (element.status == '2') {
            acceptedPurchaseMoneyRequest.add(element);
          } else if (element.status == '3') {
            rejectedPurchaseMoneyRequest.add(element);
          }
        });
      }
    } on dio.DioError catch (e) {
      print('Error : $e');
    }
  }

  getAdminData() async {
    List<PurchaseMoneyRequestModel> requests = [];
    if (hive!.get('employee_id') == adminhive!.get('neways_boss_id')) {
      try {
        dio.Response response = await _dio.get('/end-point-here');

        if (response.statusCode == 200) {
          response.data.forEach((element) {
            requests.add(PurchaseMoneyRequestModel.fromMap(element));
          });
          // requests = requests.reversed.toList();
          adminPendingPurchaseMoneyRequest.value = requests;
        }
      } on dio.DioError catch (e) {
        print('Error : $e');
      }
    }
  }
}
