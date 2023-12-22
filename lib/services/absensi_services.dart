import 'package:app/global_resource.dart';
import 'package:dio/dio.dart' as dio;

final AbsensiServices _service = AbsensiServices._();

class AbsensiServices extends GetConnect implements GetxService {
  AbsensiServices._();

  factory AbsensiServices() => _service;

  final box = GetStorage();

  Future hadirPost(body) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};

    dio.FormData formData = dio.FormData.fromMap({
      'IDKaryawan': body?['IDKaryawan'],
      'NamaKaryawan': body?['NamaKaryawan'],
      'AlamatLatitude': body?['AlamatLatitude'],
      'AlamatLongtitude': body?['AlamatLongtitude'],
      'AlamatLoc': body?['AlamatLoc'],
      'IDPerusahaan': body?['IDPerusahaan'],
      'NamaPerusahaan': body?['NamaPerusahaan'],
      "Foto": await dio.MultipartFile.fromFile(body?['Foto']?['filePath'],
          filename: body?["Foto"]?["fileName"]),
    });

    final options = dio.Options(headers: header);

    try {
      var test = await kDio
          .post(Base.url + Base.absenHadir, data: formData, options: options);
      return test;
    } catch (e) {
      return [];
    }
  }

  Future findIndiv(Map<String, String> params) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);

    try {
      final uri = Uri.parse("${Base.url}${Base.absenIndie}")
          .replace(queryParameters: params);
      var test = await kDio.get(uri.toString(), options: options);
      return test;
    } catch (e) {
      return [];
    }
  }

  Future pulangPut(param, body) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);

    dio.FormData formData = dio.FormData.fromMap({
      'LongtitudePulang': body?['LongtitudePulang'],
      'LatitudePulang': body?['LatitudePulang'],
      'AlamatPulang': body?['AlamatPulang'],
      'NamaKaryawan': body?['NamaKaryawan'],
      "Foto": await dio.MultipartFile.fromFile(body?['Foto']?['filePath'],
          filename: body?["Foto"]?["fileName"]),
    });

    try {
      var test = await kDio.put(
          "${Base.url}${Base.absenPulang}?id=${param['id']}",
          data: formData,
          options: options);
      return test;
    } catch (e) {
      return [];
    }
  }

  Future izinPost(body) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    print(body);
    print(body?["DokumenIjin"]["path"].toString());
    print(body?["DokumenIjin"]["name"].toString());
    dio.FormData formData = dio.FormData.fromMap({
      'IDKaryawan': body?['idkaryawan'],
      'NamaKaryawan': body?['namaKaryawan'],
      'Keterangan': body?["Keterangan"],
      'Ijin': body?["Ijin"],
      'DokumenIjin': await dio.MultipartFile.fromFile(
          body?["DokumenIjin"]["path"],
          filename: body?["DokumenIjin"]["name"]),
      'IDPerusahaan': body?['idperusahaan'],
      'NamaPerusahaan': body?['namaPerusahaan']
    });

    final options = dio.Options(headers: header);

    try {
      var test = await kDio
          .post(Base.url + Base.absenIzin, data: formData, options: options);
      return test;
    } on dio.DioError catch (e) {
      print(e.response?.data.toString());
      return [];
    }
  }
}
