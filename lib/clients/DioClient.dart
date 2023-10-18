import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio instance() {
    return _dio ?? Dio();
  }
}
