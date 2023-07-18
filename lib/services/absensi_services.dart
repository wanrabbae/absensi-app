import 'package:app/global_resource.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import 'dart:developer';

class AbsensiServices extends GetConnect implements GetxService {
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
      var test = await dio.Dio()
          .post(Base.url + Base.absenHadir, data: formData, options: options);
      return test;
    } catch (e) {
      return [];
    }
  }

  Future pulangPut(param, body) async {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    final options = dio.Options(headers: header);

    return put(
        '${Base.url}${Base.absenPulang}?id=${param['id']}',
        headers: header,
        body);
  }

  Future izinPost(body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return post(Base.url + Base.absenIzin, headers: header, body);
  }
}
