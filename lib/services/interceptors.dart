import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_ways_app/features/auth/views/log_in_page.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:platform_device_id/platform_device_id.dart';

class ElTanvirInterceptors extends Interceptor {
  Box? hive;
  Box? adminhive;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      await Hive.initFlutter();
    } catch (e) {
      print(e);
    }
    hive = await Hive.openBox('dataBox');
    adminhive = await Hive.openBox('adminHiveBox');
    // options.headers['Content-Type'] = 'application/json';
    // options.headers['Charset'] = 'utf-8';
    if (hive!.get('token') != null && hive!.get('token') != '') {
      options.headers['authorization'] = 'Bearer ' + hive!.get('token');
      // options.headers['device'] = _userController.deviceID;
    }
    String? deviceId = await PlatformDeviceId.getDeviceId;
    options.headers['Device'] = deviceId;
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      showToast('Session Expired');
      hive!.clear();
      adminhive!.clear();
      getx.Get.off(() => LoginPage());
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error ${err.message} => PATH: ${err.response?.realUri}');

    if (err.response?.statusCode == 401) {
      showToast('Session Expired');
      hive!.clear();
      adminhive!.clear();
      getx.Get.off(() => LoginPage());
    }
    return super.onError(err, handler);
  }
}
