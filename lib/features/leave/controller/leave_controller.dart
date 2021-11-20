import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/auth/models/user_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/leave/models/employee_leave_approval_table_model.dart';
import 'package:new_ways_app/features/leave/models/userLeaveApprovalModel.dart';
import 'package:new_ways_app/features/leave/models/user_leave_model.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:new_ways_app/utils/widgets.dart';

class LeaveController extends GetxController {
  Box? hive;
  Box? adminhive;
  UserController _userController = Get.find<UserController>();
  dio.Dio _dio = getDio();
  RxList<UserLeaveModel> leaveRequestsPending = <UserLeaveModel>[].obs;
  RxList<UserLeaveModel> leaveRequestsRejected = <UserLeaveModel>[].obs;
  RxList<UserLeaveModel> leaveRequestsApproved = <UserLeaveModel>[].obs;
  RxList<UserLeaveApprovalModel> leaveRequestsForApproval =
      <UserLeaveApprovalModel>[].obs;

  List<UserModel> subordinates = [];

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    await getLeaveHistory();
    await getLeaveRequstsForApproval();
    getSubordinates();
  }

  getSubordinates() async {
    if (hive!.get('d_head') == '1') {
      try {
        subordinates.clear();
        dio.Response response = await _dio.get('/end-point-here');
        response.data.forEach((element) {
          subordinates.add(UserModel.fromMap(element));
        });
        print(subordinates.length);
      } on dio.DioError catch (e) {
        print('getSubordinates Error: $e');
      }
    }
  }

  Future<void> getLeaveHistory() async {
    leaveRequestsPending.clear();
    leaveRequestsRejected.clear();
    leaveRequestsApproved.clear();
    String id = hive!.get('employee_id');
    if (id == '') {
      id = _userController.user.value.employee_id!;
    }
    print(' trying to getLeaveHistory : ${hive!.get('token')}');
    List<UserLeaveModel> requests = [];

    try {
      dio.Response response = await _dio.get('/end-point-here');

      if (response.statusCode == 200) {
        response.data.forEach((element) {
          requests.add(UserLeaveModel.fromMap(element));
        });

        if (requests.length != 0) {
          requests.reversed.forEach((element) {
            if (element.h_aproval == '1' && element.aproval == '1') {
              leaveRequestsApproved.add(element);
            } else if (element.h_aproval == '2' || element.aproval == '2') {
              leaveRequestsRejected.add(element);
            } else {
              leaveRequestsPending.add(element);
            }
          });
        }

        update();
      } else {
        leaveRequestsPending.value = [];
        leaveRequestsRejected.value = [];
        leaveRequestsApproved.value = [];
        update();
      }
    } on dio.DioError catch (e) {
      if (e.response!.statusCode == 404) {
        leaveRequestsPending.value = [];
        leaveRequestsRejected.value = [];
        leaveRequestsApproved.value = [];
      }
    }
  }

  Future<dio.Response> requestFullDayLeave(
      UserLeaveModel userLeaveModel, List<DateTime> dates) async {
    dio.Response? resp;

    try {
      dio.Response response = await _dio.post('/end-point-here',
          data: userLeaveModel.toMap(),
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
      print(response.data);
      print('Check Check 2: ${userLeaveModel.toMap()}');
      resp = response;
      if (response.statusCode == 201) {
        print('leveRequestSuccessfull general');
        // if (adminhive!.get('department_head_id') != null &&
        //     adminhive!.get('department_head_id') != '') {

        for (int i = 0; i < dates.length; i++) {
          String fullDate =
              DateFormat('dd/MM/yyyy').format(dates[i]).toString();

          final Map<String, dynamic> someMap =
              userLeaveModel.toMapForEveryDayLeavLogTable();
          someMap['date_full'] = fullDate;
          someMap['days'] = dates[i].day.toString();
          someMap['month'] = dates[i].month.toString();
          someMap['year'] = dates[i].year.toString();

          dio.Response response = await _dio.post('/end-point-here',
              data: someMap,
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType));
          print(response.statusCode);
          resp = response;
          if (response.statusCode == 201) {
            print('leveRequestToeveryDayLevaLogTableSuccessfull genral');
          }
        }
      }
    } on dio.DioError catch (e) {
      showErrorDialouge(e.message);
    }

    getLeaveHistory();
    return resp!;
  }

  removeLeaveRequest(UserLeaveModel userLeaveModel) async {
    dio.Response response = await _dio.delete('/end-point-here');
    if (response.statusCode == 200) {
      print('data removed successfully');
      dio.Response response = await _dio.delete('/end-point-here');

      if (response.statusCode == 200) {
        print('successfully Removed from every day table');
      }

      getLeaveHistory();
    }
  }

  getHRLeaveRequstsForApproval() async {
    List<UserLeaveApprovalModel> requestsForApproval = [];
    List<String> alldepartments = [];
    List<String> dheadlessdepartments = [];

    dio.Response response = await _dio.get('/end-point-here');
    response.data.forEach((element) {
      alldepartments.add(element['department_id']);
    });

    alldepartments.forEach((element) async {
      dio.Response _response = await _dio.get('/end-point-here');
      if (_response.data.length == 0) {
        dheadlessdepartments.add(element);
      }
    });
    dheadlessdepartments.add('1383007286312996344');
    print('dhead less Departments : ${dheadlessdepartments.length}');

    dheadlessdepartments.forEach((element) async {
      dio.Response _responsed = await _dio.get('/end-point-here');
      _responsed.data.forEach((element) {
        requestsForApproval.add(UserLeaveApprovalModel.fromMap(element));
      });
    });
    leaveRequestsForApproval.value = requestsForApproval.reversed.toList();
    update();
  }

  getLeaveRequstsForApproval() async {
    List<UserLeaveApprovalModel> requestsForApproval = [];
    String hApproval = '0';
    String andQuery = '';
    print(adminhive!.get('neways_branch_operationhead'));

// hive!.get('department') == '2392358440567352112' ||
//         hive!.get('department') == '1810685559802248792'
    if (hive!.get('employee_id') !=
            adminhive!.get('neways_branch_operationhead') &&
        hive!.get('employee_id') != adminhive!.get('neways_boss_id')) {
      hApproval = '0';
      andQuery = 'query';
    }

    // else if (hive!.get('employee_id') ==
    //     adminhive!.get('neways_branch_operationhead')) {
    //   hApproval = '3';
    // }

    else {
      if (hive!.get('employee_id') == adminhive!.get('neways_boss_id')) {
        hApproval = '1';
      } else if (hive!.get('employee_id') ==
          adminhive!.get('neways_branch_operationhead')) {
        print('For Adib Should be Here');
        hApproval = '3';
        andQuery = '_____employee.branch:=:${hive!.get('branch')}';
      }
    }
    try {
      dio.Response response = await _dio.get('/end-point-here');
      response.data.forEach((element) {
        requestsForApproval.add(UserLeaveApprovalModel.fromMap(element));
      });
      print(response.realUri);
      // List<UserLeaveApprovalModel> abc =
      //     await getMatchingRequests(requestsForApproval);
      leaveRequestsForApproval.value = requestsForApproval.reversed.toList();
      update();
    } on dio.DioError catch (e) {
      print(e);
    }
  }

  rejectLeaveRequest(String primaryKey) async {
    dio.Response response = await _dio.post('/end-point-here',
        data: {'h_aproval': '2'},
        options:
            dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
    if (response.statusCode == 200) {
      getLeaveRequstsForApproval();
      print('leave rejected successfully');
    }
  }

  acceptLeaveRequest(UserLeaveApprovalModel leavemodel) async {
    String currentUserDheadValue = hive!.get('d_head');
    String currentUserDepartmentID = hive!.get('department');
    String hApproval = '1';
    String approval = '0';

    if (currentUserDepartmentID == '1810685559802248792' ||
        currentUserDepartmentID == '2392358440567352112') {
      if (currentUserDheadValue == '1') {
        hApproval = '3';
      }
    } else {
      if (currentUserDepartmentID == '749568347163692080') {
        approval = '1';
      } else if ((leavemodel.department == '1810685559802248792' ||
              leavemodel.department == '2392358440567352112') &&
          hive!.get('employee_id') ==
              adminhive!.get('neways_branch_operationhead')) {
        hApproval = '1';
        approval = '1';
      } else if (currentUserDheadValue == '1') {
        hApproval = '1';
      }
    }
    print('Accepted With $hApproval : $approval');
    try {
      dio.Response response = await _dio.post('/end-point-here',
          data: {'h_aproval': hApproval, 'aproval': approval},
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (hApproval == '1' && approval == '1') {
          // _userController.createNotification(
          //     type: 'personal',
          //     id: leavemodel.employee_id!,
          //     title: 'Leave Approved',
          //     message:
          //         'Your Leave Starting from ${leavemodel.start_days} to ${leavemodel.end_date} has been Approved');
          _userController.createNotification(
              type: 'broadcast',
              broadcast_scope: 'company',
              title: 'Leave Approved',
              message:
                  '${leavemodel.full_name} is going on Leave for ${leavemodel.how_many_days} starting from ${leavemodel.start_days}');
        } else if (hApproval == '1') {
          _userController.createNotification(
              type: 'personal',
              id: adminhive!.get('neways_boss_id'),
              title: 'Leave Request',
              message:
                  '${leavemodel.full_name} Requested Leave for ${leavemodel.how_many_days} day(s) starting from ${leavemodel.start_days}');
        } else if (hApproval == '3') {
          _userController.createNotification(
              type: 'personal',
              id: hive!.get('neways_branch_operationhead'),
              title: 'Leave Request',
              message:
                  '${leavemodel.full_name} Requested Leave for ${leavemodel.how_many_days} day(s) starting from ${leavemodel.start_days}');
        }
        getLeaveRequstsForApproval();
      }
      print(response.statusCode);
    } on dio.Dio catch (e) {
      print('Approval Error : $e');
    }
  }

  insertDataToEmployeeLeaveApprovalTable(
      EmployeeLeaveApprovalTableModel approval) async {
    var rollName = hive!.get('rollName');
    var email = hive!.get('email');
    var branchId = hive!.get('branchId');
    Map<String, dynamic> map = approval.toMap();

    map['uploader_info'] = "${rollName}___${email}___$branchId";
    dio.Response response = await _dio.post('/end-point-here',
        data: map,
        options:
            dio.Options(contentType: dio.Headers.formUrlEncodedContentType));

    if (response.statusCode == 201) {
      print('Data inserted to employee approval table successfully');
    }
  }

  Future<List<EmployeeLeaveApprovalTableModel>> getLeaveSpecificLogs(
      String leaveID) async {
    List<EmployeeLeaveApprovalTableModel> list = [];
    try {
      dio.Response response = await _dio.get('/end-point-here');
      response.data.forEach((element) {
        list.add(EmployeeLeaveApprovalTableModel.fromMap(element));
      });
      print(response.realUri);
      list = list.reversed.toList();
    } on dio.DioError catch (e) {
      print(e);
    }
    return list;
  }
}
