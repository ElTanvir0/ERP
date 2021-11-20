import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/advancesalary/models/advance_salary_model.dart';
import 'package:new_ways_app/features/advancesalary/models/salary_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:dio/dio.dart' as dio;

class SalaryController extends GetxController {
  dio.Dio _dio = getDio();
  Box? hive;
  Box? adminhive;
  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    getpastSalaries();
    getUserAdvanceSalaryRequest();
    getAdminAdvanceSalaryRequest();
  }

  UserController _userController = Get.find<UserController>();

  RxList<SalaryModel> allSalaries = <SalaryModel>[].obs;
  RxList<AdvanceSalaryModel> acceptedAdvanceSalaries =
      <AdvanceSalaryModel>[].obs;
  RxList<AdvanceSalaryModel> pendingAdvanceSalaries =
      <AdvanceSalaryModel>[].obs;
  RxList<AdvanceSalaryModel> rejectedAdvanceSalaries =
      <AdvanceSalaryModel>[].obs;
  RxList<AdvanceSalaryModel> adminAdvanceSalaries = <AdvanceSalaryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  respondToAdvanceSalaryRequest(String approval, AdvanceSalaryModel data) {
    Map<String, dynamic> respons = {};
    if ((hive!.get('employee_id') == adminhive!.get('neways_boss_id')) ||
        hive!.get('department') == '2270968637477766714') {
      if (hive!.get('employee_id') == adminhive!.get('neways_boss_id')) {
        respons = {
          'aproval': approval,
        };
      } else if (hive!.get('department') == '2270968637477766714') {
        respons = {
          'aproval_account': approval,
        };
      }

      try {
        _dio
            .post('/end-point-here',
                data: respons,
                options: dio.Options(
                    contentType: dio.Headers.formUrlEncodedContentType))
            .then((value) {
          _dio
              .post('/end-point-here',
                  data: {
                    'id': '',
                    'e_db_id': data.e_db_id,
                    'employee_id': data.employee_id,
                    'grant_loan_id': data.id,
                    'aproval_type': (approval == '1') ? 'Approved' : 'Rejeted',
                    'note':
                        '${(approval == '1') ? 'Approved' : 'Rejected'} by ${hive!.get('email')}',
                    'status': "1",
                    'uploader_info':
                        '${hive!.get('role_name')}___${hive!.get('email')}___${hive!.get('branch')}',
                    'data':
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  },
                  options: dio.Options(
                      contentType: dio.Headers.formUrlEncodedContentType))
              .then((value) {
            if (value.statusCode == 201) {
              showToast(
                  'Succesfully ${(approval == '1') ? 'Approved' : 'Rejected'}');

              if (hive!.get('employee_id') ==
                      adminhive!.get('neways_boss_id') &&
                  approval == '1') {
                _userController.createNotification(
                    type: 'broadcast',
                    broadcast_scope: 'department',
                    department: '2270968637477766714',
                    message:
                        "Boss has Approved ${data.full_name}'s Advance Salary Request of amount ${data.amount}৳",
                    title: 'Advance Salary Request Approved');
              } else if (hive!.get('department') == '2270968637477766714' &&
                  approval == '1') {
                _userController.createNotification(
                    type: 'personal',
                    id: data.employee_id!,
                    message:
                        'Your Request For Advance Salary of amount ${data.amount}৳ Has been Approved',
                    title: 'Advance Salary Request Apporved');
              }
              ;
              getpastSalaries();
              getUserAdvanceSalaryRequest();
              getAdminAdvanceSalaryRequest();
            }
          });
        });
      } on dio.DioError catch (e) {
        print('respondToAdvanceSalaryRequest Error: ${e.message}');
      }
    }
  }

  sendNewAdvanceSalaryRequest(
      {required String amount, required String note}) async {
    Map<String, dynamic> data = {
      'amount': amount,
      'note': note,
    };
    try {
      await _dio
          .post('/advance-salary',
              data: data,
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (value.statusCode == 201 || value.statusCode == 200) {
          _userController.createNotification(
              id: adminhive!.get('neways_boss_id'),
              type: 'personal',
              title: 'Advance Salary',
              message:
                  '${hive!.get('full_name')} Requested Advance Salary of amount $amount৳');
          showToast('Successfully Request Advance Salary');
          getpastSalaries();
          getUserAdvanceSalaryRequest();
          getAdminAdvanceSalaryRequest();
          Get.back();
        }
      });
    } on dio.DioError catch (e) {
      if (e.response != null) {
        showToast(e.response!.data);
      }
    }
  }

  getpastSalaries() async {
    allSalaries.clear();
    List<SalaryModel> salaries = [];
    try {
      dio.Response response = await _dio.get('/end-point-here');

      if (response.statusCode == 200) {
        response.data.forEach((element) {
          salaries.add(SalaryModel.fromMap(element));
        });

        allSalaries.value = salaries.reversed.toList();
      }
    } on dio.DioError catch (e) {
      print(e.message);
    }
  }

  getUserAdvanceSalaryRequest() async {
    acceptedAdvanceSalaries.clear();
    pendingAdvanceSalaries.clear();
    rejectedAdvanceSalaries.clear();
    List<AdvanceSalaryModel> advSalaries = [];
    try {
      dio.Response response = await _dio.get('/end-point-here');

      if (response.statusCode == 200) {
        response.data.forEach((element) {
          advSalaries.add(AdvanceSalaryModel.fromMap(element));
        });
        advSalaries.reversed.toList().forEach((element) {
          if (element.aproval == '2' || element.aproval_account == '2') {
            rejectedAdvanceSalaries.add(element);
          } else if (element.aproval == '1' && element.aproval_account == '1') {
            acceptedAdvanceSalaries.add(element);
          } else {
            pendingAdvanceSalaries.add(element);
          }
        });
      }
    } on dio.DioError catch (e) {
      print(e.message);
    }
  }

  getAdminAdvanceSalaryRequest() async {
    adminAdvanceSalaries.clear();
    List<AdvanceSalaryModel> advSalaries = [];

    String query = 'query';

    if (hive!.get('department') == '2270968637477766714' ||
        hive!.get('employee_id') == adminhive!.get('neways_boss_id')) {
      if (hive!.get('employee_id') == adminhive!.get('neways_boss_id')) {
        query = 'query';
      } else if (hive!.get('department') == '2270968637477766714') {
        query = 'query';
      }

      try {
        dio.Response response = await _dio.get('/end-point-here');

        if (response.statusCode == 200) {
          response.data.forEach((element) {
            advSalaries.add(AdvanceSalaryModel.fromMap(element));
          });
          print('Got Admin Data : ${advSalaries.length}');
          adminAdvanceSalaries.value = advSalaries.reversed.toList();
        }
      } on dio.DioError catch (e) {
        print(e.message);
      }
    }
  }
}
