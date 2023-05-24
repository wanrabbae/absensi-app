import 'package:app/global_resource.dart';

class HomeServices extends GetConnect implements GetxService {
  final box = GetStorage();

  Future<Response> absenGet(params) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.absensi, headers: header, query: params);
  }

  Future<Response> perusahaanGet(params) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.perusahaan, headers: header, query: params);
  }

  Future<Response> searchPerusahaanGet(params) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.searchPerusahaan,
        headers: header, query: params);
  }

  Future<Response> searchUserGet(params) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return get(Base.url + Base.searchUser, headers: header, query: params);
  }

  Future<Response> undanganPost(body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return post('${Base.url}${Base.undangan}', headers: header, body);
  }
}
