import 'package:app/global_resource.dart';

class AuthServices extends GetConnect implements GetxService {
  final box = GetStorage();

  Future<Response> sendLinkPost(email) {
    return post('${Base.url}${Base.linkLogin}?email=$email', {});
  }

  Future<Response> verifyOtpGet(params) {
    return get(Base.url + Base.loginOtp, query: params);
  }

  Future<Response> imageGet(url) {
    return get(Base.url);
  }
}
