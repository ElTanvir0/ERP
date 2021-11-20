import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/tada/models/tadaApprovalModel.dart';
import 'package:new_ways_app/features/tada/models/tadaDatamodel.dart';
import 'package:new_ways_app/features/tada/models/tadamodel.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class TaDaPageController extends GetxController {
  RxList<TadaModel> tadaLish = <TadaModel>[].obs;
  UserController _userController = Get.find<UserController>();
  dio.Dio _dio = getDio();
  Box? hive;
  Box? adminhive;

//Stores All User TADA data For Reactive Update
  RxList<TadaModel> userAcceptedTADA = <TadaModel>[].obs;
  RxList<TadaModel> userPendingTADA = <TadaModel>[].obs;
  RxList<TadaModel> userRejectedTADA = <TadaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeEverything();
  }

  initializeEverything() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    await getAllTaDa();
    await getAllUserData();
  }

  String getTransactionID() {
    DateTime datetime = DateTime.now();
    return 'CO1-${DateFormat('ddMMyy-hhmmss-S').format(datetime)}';
  }

// Only Called When Accounts Approves
  Future<void> sendDataToPaymentReceived(TaDaDataModel data) async {
    var trans = {
      'account': 'TA/DA Return Account',
      'care_of': data.employee_id,
      'transaction':
          int.parse((data.food_amount == '') ? '0' : data.food_amount!) +
              int.parse(
                  (data.transport_amount == '') ? '0' : data.transport_amount!),
      'payment_method': {
        'cash': int.parse((data.food_amount == '') ? '0' : data.food_amount!) +
            int.parse(
                (data.transport_amount == '') ? '0' : data.transport_amount!),
      }
    };

    print('getting Called From Accounts approval $trans');

    try {
      await _dio
          .post(
        '/transaction',
        data: trans,
        options: dio.Options(contentType: dio.Headers.jsonContentType),
      )
          .then((value) {
        _userController.createNotification(
            type: 'personal',
            id: data.employee_id!,
            title: 'TA/DA Approved',
            message:
                'Your TA/DA of ${int.parse((data.food_amount == '') ? '0' : data.food_amount!) + int.parse((data.transport_amount == '') ? '0' : data.transport_amount!)}৳ has been Approved');
      });
    } on dio.DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> respondTadaRequest(
      TaDaDataModel data, String approval, String? note) async {
    String department_head_aproval = data.department_head_aproval!;
    String boss_aproval = data.boss_aproval!;
    String accounts_aproval = data.accounts_aproval!;
    String self_aproval = data.self_aproval!;
    TadaApprovalModel _tadaApproval = TadaApprovalModel.fromTadaModel(data);

    if (data.department_head_aproval == '0') {
      department_head_aproval = approval;
      _tadaApproval = _tadaApproval.copyWith(
          note: note,
          aproval_type: 'Department Head Approval',
          uploader_info:
              '${_userController.hive!.get('role_name')}___${_userController.hive!.get('email')}___${_userController.hive!.get('branch')}');
    } else if (data.boss_aproval == '0') {
      boss_aproval = approval;
      _tadaApproval = _tadaApproval.copyWith(
          note: note,
          aproval_type: 'Boss Approval',
          uploader_info:
              '${_userController.hive!.get('role_name')}___${_userController.hive!.get('email')}___${_userController.hive!.get('branch')}');
    } else if (data.accounts_aproval == '0') {
      accounts_aproval = approval;
      _tadaApproval = _tadaApproval.copyWith(
          note: note,
          aproval_type: 'Accounts Approval',
          uploader_info:
              '${_userController.hive!.get('role_name')}___${_userController.hive!.get('email')}___${_userController.hive!.get('branch')}');
    } else if (data.self_aproval == '0') {
      self_aproval = approval;
      _tadaApproval = _tadaApproval.copyWith(
          note: note,
          aproval_type: 'Self Approval',
          uploader_info:
              '${_userController.hive!.get('role_name')}___${_userController.hive!.get('email')}___${_userController.hive!.get('branch')}');
    }

    try {
      _dio
          .post('/end-point-here',
              data: {
                'department_head_aproval': department_head_aproval,
                'boss_aproval': boss_aproval,
                'accounts_aproval': accounts_aproval,
                'self_aproval': self_aproval,
                'note': note
              },
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (self_aproval != '1' && self_aproval != '2') {
          if (department_head_aproval == '1' &&
              boss_aproval == '1' &&
              accounts_aproval == '1') {
          } else if (department_head_aproval == '1' && boss_aproval == '1') {
            _userController.createNotification(
                type: 'broadcast',
                broadcast_scope: 'department',
                department: '2270968637477766714',
                title: 'TA/DA pending',
                message:
                    'TA/DA Request of amount ${int.parse((data.food_amount == '') ? '0' : data.food_amount!) + int.parse((data.transport_amount == '') ? '0' : data.transport_amount!)}৳ pending your action');
          } else if (department_head_aproval == '1') {
            _userController.createNotification(
                type: 'personal',
                id: _userController.adminhive!.get('neways_boss_id'),
                title: 'TA/DA pending',
                message:
                    'TA/DA Request of amount ${int.parse((data.food_amount == '') ? '0' : data.food_amount!) + int.parse((data.transport_amount == '') ? '0' : data.transport_amount!)}৳ pending your action');
          }
        }

        _dio
            .post('/end-point-here',
                data: _tadaApproval.toMap(),
                options: dio.Options(
                    contentType: dio.Headers.formUrlEncodedContentType))
            .then((value) async {
          getAllTaDa();
          getAllUserData();
          if (department_head_aproval == '1' &&
              boss_aproval == '1' &&
              accounts_aproval == '1' &&
              self_aproval == '0') {
            await sendDataToPaymentReceived(data);
          }
        });
        print(
            'department_head_aproval: ${department_head_aproval} , boss_aproval: ${boss_aproval}, accounts_aproval : ${accounts_aproval}, self_aproval : ${self_aproval},note: $note');
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  getAllTaDa() async {
    try {
      dio.Response response = await _dio.get('/ta-da');
      List<TadaModel> tadas = [];

      jsonDecode(response.data).forEach((element) {
        tadas.add(TadaModel.fromMap(element));
      });
      tadaLish.value = tadas.reversed.toList();
      print('Jimmy : ${response.requestOptions.path}');
    } catch (e) {
      print('Error Loading Tada List');
    }
  }

  getAllUserData() async {
    List<TadaModel> tadas = [];
    userAcceptedTADA.clear();
    userPendingTADA.clear();
    userRejectedTADA.clear();
    try {
      dio.Response response = await _dio.get('/end-point-here');

      response.data.forEach((element) {
        tadas.add(TadaModel.fromJson(element));
      });

      if (tadas.length != 0) {
        tadas.reversed.toList().forEach((element) {
          if (element.data.accounts_aproval == '1' &&
              element.data.department_head_aproval == '1' &&
              element.data.boss_aproval == '1' &&
              element.data.self_aproval == '1') {
            userAcceptedTADA.add(element);
          } else if (element.data.accounts_aproval == '2' ||
              element.data.department_head_aproval == '2' ||
              element.data.boss_aproval == '2' ||
              element.data.self_aproval == '2') {
            userRejectedTADA.add(element);
          } else {
            userPendingTADA.add(element);
          }
        });
      }
    } on dio.DioError catch (e) {
      print(e.requestOptions.path);
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "ta_da_file":
          await dio.MultipartFile.fromFile(file.path, filename: fileName),
    });
    dio.Response response = await _dio.post("/file", data: formData);
    print(response.data);
    return response.data;
  }

  Future<void> requestTada(TaDaDataModel _dataModel) async {
    try {
      dio.Response response = await _dio.post('/end-point-here',
          data: _dataModel.toMap(),
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));

      if (response.statusCode == 201) {
        showToast('Your TA/DA Request Has been posted Successfully');
        _userController.createNotification(
            id: _userController.adminhive!.get('department_head_id'),
            message:
                'One of your subordinate Request TA/DA of amount ${int.parse((_dataModel.food_amount == '') ? '0' : _dataModel.food_amount!) + int.parse((_dataModel.transport_amount == '') ? '0' : _dataModel.transport_amount!)}. Please Respond',
            title: 'TA/DA Request',
            type: 'personal');
        getAllTaDa();
        getAllUserData();
        Get.back();
      } else {
        Get.snackbar('Ta/Da Request', '${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kPrimaryColor);
        print(response.statusCode);
      }
    } on dio.DioError catch (e) {
      print(e.message);
    }
  }

  Future<List<TadaApprovalModel>> getTaDaSpecificLogs(String tadaID) async {
    List<TadaApprovalModel> list = [];
    try {
      dio.Response response = await _dio.get('/end-point-here');
      response.data.forEach((element) {
        list.add(TadaApprovalModel.fromMap(element));
      });
      print(response.realUri);
      list = list.reversed.toList();
    } on dio.DioError catch (e) {
      print(e);
    }
    return list;
  }
}
