import 'package:app/global_resource.dart';

class ProfileServices extends GetConnect implements GetxService {
  final box = GetStorage();

  Future<Response> profileGet(params) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.profileView, headers: header, query: params);
  }

  Future<Response> profileUpdatePut(param, body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return put(
        '${Base.url}${Base.profileUpdate}?email=${param['email']}',
        headers: header,
        body);
  }

  Future<Response> profileDeletePut(param, body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return put(
        '${Base.url}${Base.profileDelete}?email=${param['email']}',
        headers: header,
        body);
  }

  Future<Response> ubahEmailPost(param, body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return post(
        '${Base.url}${Base.ubahEmail}?emaillama=${param['email']}',
        headers: header,
        body);
  }

  Future<Response> ubahEmailVerifyPost(query) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.verifyUbahEmail, headers: header, query: query);
  }
}
