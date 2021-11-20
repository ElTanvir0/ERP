import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_ways_app/features/car_rqusition/models/car_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/car_req_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/cars_and_branches_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/cr_branch_model.dart';
import 'package:new_ways_app/features/car_rqusition/models/requsition_data_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:dio/dio.dart' as dio;

class CarRequsitionController extends GetxController {
  Box? hive;
  Box? adminhive;
  dio.Dio _dio = dio.Dio();
  RxList<CarModel> carList = <CarModel>[].obs;
  RxList<BranchModelCR> branchList = <BranchModelCR>[].obs;
  RxList<CarRequisitionModel> requistions = <CarRequisitionModel>[].obs;
  RxList<CarRequisitionModel> userRequistions = <CarRequisitionModel>[].obs;
  RxList<CarRequisitionModel> adminAttention = <CarRequisitionModel>[].obs;
  RxList<CarRequisitionModel> scheduledrequistions =
      <CarRequisitionModel>[].obs;
  RxList<CarRequisitionModel> driverUpcomingRide = <CarRequisitionModel>[].obs;
  RxList<CarRequisitionModel> driverActiveRide = <CarRequisitionModel>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> driverselectedDate = DateTime.now().obs;
  UserController _userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    _dio = getDio();
    getCarsAndBranches();
    (hive!.get('designation') == '1891238078957544400')
        ? getDriverSchedules()
        : getDateWiseRequistion();
    (hive!.get('designation') == '1891238078957544400')
        ? getDriverUpcomingRide()
        : () {};
    update();
  }

  getDriverSchedules() async {
    dio.Response? response;
    List<CarRequisitionModel> crab = [];
    try {
      response = await _dio.post('/scheduled-rides',
          data: {
            'date': DateFormat('yyyy-MM-dd').format(driverselectedDate.value)
          },
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));

      jsonDecode(response.data).forEach((element) {
        crab.add(CarRequisitionModel.fromMap(element));
      });

      scheduledrequistions.value = crab.reversed.toList();
    } on dio.DioError catch (e) {
      scheduledrequistions.value = <CarRequisitionModel>[];
      print(e);
    } on Exception catch (e) {
      scheduledrequistions.value = <CarRequisitionModel>[];
      print(e);
    }
  }

  getDriverUpcomingRide() async {
    dio.Response? response;

    List<CarRequisitionModel> crab = [];
    driverUpcomingRide.value = <CarRequisitionModel>[];
    driverActiveRide.value = <CarRequisitionModel>[];
    try {
      response = await _dio.get(
        '/upcoming-ride',
      );

      crab.add(CarRequisitionModel.fromMap(jsonDecode(response.data)));
      if (crab.first.status == '2') {
        driverUpcomingRide.value = crab.reversed.toList();
      } else if (crab.first.status == '3') {
        driverActiveRide.value = crab.reversed.toList();
      }
    } on dio.DioError catch (e) {
      driverUpcomingRide.value = <CarRequisitionModel>[];
      driverActiveRide.value = <CarRequisitionModel>[];
      print(e);
    } on Exception catch (e) {
      driverUpcomingRide.value = <CarRequisitionModel>[];
      driverActiveRide.value = <CarRequisitionModel>[];
      print(e);
    }
  }

  getDateWiseRequistion() async {
    dio.Response? response;
    requistions.value = <CarRequisitionModel>[];
    userRequistions.value = <CarRequisitionModel>[];
    adminAttention.value = <CarRequisitionModel>[];
    List<CarRequisitionModel> crab = [];
    List<CarRequisitionModel> crabv2 = [];
    List<CarRequisitionModel> crabv3 = [];

    try {
      response = await _dio.post('/service-requisition/show',
          data: {'date': DateFormat('yyyy-MM-dd').format(selectedDate.value)},
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));

      jsonDecode(response.data).forEach((element) {
        crab.add(CarRequisitionModel.fromMap(element));
      });
      crab.forEach((element) {
        if (element.requisition_by == hive!.get('employee_id')) {
          crabv2.add(element);
        }
      });

      crab.forEach((element) {
        if ((hive!.get('employee_id') == adminhive!.get('neways_boss_id')) &&
            (element.status == '1' || element.status == '5')) {
          crabv3.add(element);
        } else if ((hive!.get('department') == '1383007286312996344') &&
            element.status == '5') {
          crabv3.add(element);
        }
      });

      requistions.value = crab.reversed.toList();
      userRequistions.value = crabv2.reversed.toList();
      adminAttention.value = crabv3.reversed.toList();
    } on dio.DioError catch (e) {
      requistions.value = <CarRequisitionModel>[];
      userRequistions.value = <CarRequisitionModel>[];
      adminAttention.value = <CarRequisitionModel>[];
      print(e);
    } on Exception catch (e) {
      requistions.value = <CarRequisitionModel>[];
      userRequistions.value = <CarRequisitionModel>[];
      adminAttention.value = <CarRequisitionModel>[];
      print(e);
    }
  }

  getCarsAndBranches() async {
    CarsAndBranchesModel crab = CarsAndBranchesModel();
    branchList.value = <BranchModelCR>[];
    carList.value = <CarModel>[];
    dio.Response? response;
    try {
      response = await _dio.get('/service-requisition');
      crab = CarsAndBranchesModel.fromJson(response.data);
      branchList.value =
          (crab.branches != null) ? crab.branches! : <BranchModelCR>[];
      branchList.add(BranchModelCR(branch_id: 'other', branch_name: 'other'));
      carList.value = (crab.cars != null) ? crab.cars! : <CarModel>[];
    } on dio.DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    }
  }

  respondtoCarRequest(
      {required CarRequisitionModel carRequisitionModel,
      required String note,
      required String status}) async {
    try {
      await _dio
          .post('/service-requisition/update/${carRequisitionModel.service_id}',
              data: {'note': note, 'status': status},
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (status == '2') {
          _userController.createNotification(
            type: 'personal',
            id: jsonDecode(value.data)['dirver_id'],
            title: 'Car Requisition',
            message: 'You Have a new Driving Schedule!',
          );
          _userController.createNotification(
            type: 'personal',
            id: carRequisitionModel.requisition_by,
            title: 'Car Requisition',
            message: 'Boss has Approved your Request for Car',
          );
        } else if (status == '0' &&
            carRequisitionModel.requisition_by != hive!.get('employee_id')) {
          _userController.createNotification(
            type: 'personal',
            id: carRequisitionModel.requisition_by,
            title: 'Car Requisition',
            message: 'Boss has Rejected your Request for Car',
          );
        } else if (status == '5') {
          _userController.createNotification(
            type: 'personal',
            id: carRequisitionModel.requisition_by,
            title: 'Car Requisition',
            message: "Your car request has been cancelled",
          );

          _userController.createNotification(
            type: 'personal',
            id: '00002',
            title: 'Car Requisition',
            message:
                "${carRequisitionModel.full_name} did't pick the car in time",
          );
          _userController.createNotification(
            type: 'broadcast',
            broadcast_scope: 'department',
            department: '1383007286312996344',
            title: 'Car Requisition',
            message:
                "${carRequisitionModel.full_name} did't pick the car in time",
          );
        }
      });
      getDateWiseRequistion();
      getDriverSchedules();
      getDriverUpcomingRide();
      // showToast(jsonDecode(response.data)['message']);
    } on dio.DioError catch (e) {
      // showToast(jsonDecode(e.response?.data)['message']);
      print(e);
    }
  }

  startRide({
    required CarRequisitionModel carRequisitionModel,
    required String note,
    required String mileage,
    required String confirmation_code,
  }) async {
    try {
      await _dio
          .post('/upcoming-ride/start/${carRequisitionModel.id}',
              data: {
                'note': note,
                'mileage': mileage,
                'confirmation_code': confirmation_code
              },
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          _userController.createNotification(
            type: 'personal',
            id: carRequisitionModel.requisition_by,
            title: 'Car Requisition',
            message: 'Your Ride Has Been Started',
          );
        }
      });

      getDriverUpcomingRide();
      // showToast(jsonDecode(response.data)['message']);
    } on dio.DioError catch (e) {
      // showToast(jsonDecode(e.response?.data)['message']);
      print(e);
    }
  }

  endRide(
      {required CarRequisitionModel carRequisitionModel,
      required String note,
      required String mileage}) async {
    try {
      await _dio
          .post('/upcoming-ride/end/${carRequisitionModel.id}',
              data: {
                'note': note,
                'status': mileage,
              },
              options: dio.Options(
                  contentType: dio.Headers.formUrlEncodedContentType))
          .then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          _userController.createNotification(
            type: 'personal',
            id: carRequisitionModel.requisition_by,
            title: 'Car Requisition',
            message: 'Your Ride Has Been Started',
          );
        }
      });

      getDriverUpcomingRide();
      // showToast(jsonDecode(response.data)['message']);
    } on dio.DioError catch (e) {
      // showToast(jsonDecode(e.response?.data)['message']);
      print(e);
    }
  }

  Future<void> requestCarRequisition(CarReqRequisitionModel _req) async {
    try {
      dio.Response response = await _dio.post('/service-requisition/insert',
          data: _req.toMap(),
          options:
              dio.Options(contentType: dio.Headers.formUrlEncodedContentType));

      if (response.statusCode == 201) {
        _userController.createNotification(
          type: 'personal',
          id: adminhive!.get('neways_boss_id'),
          title: 'Car Requisition',
          message: "${hive!.get('full_name')} Requested for a car",
        );
      }
      showToast(jsonDecode(response.data)['message']);
    } on dio.DioError catch (e) {
      showToast(jsonDecode(e.response?.data)['message']);
    }
  }
}
