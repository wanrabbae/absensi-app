import 'package:app/global_resource.dart';
import 'package:dio/dio.dart' as dio;

final HomeServices _homeServices = HomeServices._();

class HomeServices extends GetConnect implements GetxService {
  HomeServices._();

  factory HomeServices() => _homeServices;

  final box = GetStorage();

  Future absenGet(Map<String, String> params) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);
    return await kDio.get(
      "${Base.url}${Base.absensi}"
      "?idperusahaan=${params['idperusahaan']}"
      "&tanggal=${params['tanggal']}",
      options: options,
    );
  }

  Future izinGet(params) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);
    return await kDio.get(
      "${Base.url}${Base.absenIzinEndpoint}"
      "?idperusahaan=${params['idperusahaan']}"
      "&tanggal=${params['tanggal']}",
      options: options,
    );
  }

  Future perusahaanGet(params) async {
    debugPrint(params.toString());
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);
    return await kDio.get(
        "${Base.url}${Base.perusahaan}?email=${params['email']}",
        options: options);
    // return get(Base.url + Base.perusahaan, headers: header, query: params);
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
