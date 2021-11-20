import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/attendence/models/attend_req_full_model.dart';
import 'package:new_ways_app/features/attendence/models/attendence_model.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class AttendenceController extends GetxController {
  List<AttendenceModel> totalAttendence = <AttendenceModel>[];
  dio.Dio _dio = getDio();
  Box? hive;
  Box? adminhive;

  initializehive() async {
    hive = await Hive.openBox(databox);
    adminhive = await Hive.openBox(adminbox);
    getAllAttendence();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initializehive();
  }

  larachara() {
    var dayCount = DateTime.monthsPerYear;
    print(dayCount);
  }

  getAllAttendence() async {
    List<AttendenceModel> attendence = [];
    ;
    try {
      dio.Response response = await _dio.get('/end-point-here');

      if (response.statusCode == 200) {
        response.data.forEach((element) {
          attendence.add(AttendenceModel.fromMap(element));
        });
        totalAttendence = attendence.toSet().toList();
        print('Total : ${attendence.length} Unique: ${totalAttendence.length}');
        update();
      }
    } on dio.DioError catch (e) {
      print('getAllAttendence Error : ${e.message}');
    }
  }

  Future<void> requestAttendence(AttendReqFullModel attendence) async {
    try {
      await _dio
          .post('/missing-attendance',
              data: attendence.toJson(),
              options: dio.Options(contentType: dio.Headers.jsonContentType))
          .then((value) {
        print(value.statusCode);
        if (value.statusCode == 201) {
          showToast('Request Successful..');
        }
      });
    } on dio.DioError catch (e) {
      print(e);
    }
  }
}
