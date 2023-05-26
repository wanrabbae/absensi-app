import 'package:app/global_resource.dart';
import 'package:dio/dio.dart' as dio;

class AuthServices extends GetConnect implements GetxService {
  final box = GetStorage();

  Future sendLinkPost(email) async {
    return await dio.Dio().post('${Base.url}${Base.linkLogin}?email=$email');
  }

  Future<Response> verifyOtpGet(params) {
    return get(Base.url + Base.loginOtp, query: params);
  }

  Future<Response> imageGet(url) {
    return get(Base.url);
  }
}
