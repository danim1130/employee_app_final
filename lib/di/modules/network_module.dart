import 'package:dio/dio.dart';
import 'package:employee_app/environment.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule{
  @singleton
  Dio dio(AppEnvironment app) {
    var _dio = Dio();
    _dio.options.baseUrl = app.userBaseUrl;
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      responseHeader: true,
    ));
    return _dio;
  }
}