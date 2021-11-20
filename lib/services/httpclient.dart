import 'package:dio/dio.dart';
import 'package:new_ways_app/services/interceptors.dart';
import 'package:new_ways_app/utils/constants.dart';

Dio getDio() {
  Dio _dio = Dio();
  _dio.options.baseUrl = baseUrl;
  _dio.options.connectTimeout = 10000;
  _dio.options.receiveTimeout = 10000;
  _dio.interceptors.add(ElTanvirInterceptors());
  return _dio;
}

  // @override
  // Future onResponse(Response response, ResponseInterceptorHandler handler) {
  //   print('RESPONSE[${response.statusCode}] => PATH: ${response.request?.path}');
  //   return super.onResponse(response, handler);
  // }
  // @override
  // Future onError(DioError err, ErrorInterceptorHandler handler) {
  //   print('ERROR[${err.response?.statusCode}] => PATH: ${err.request.path}');
  //   return super.onError(err, handler);
  // }
