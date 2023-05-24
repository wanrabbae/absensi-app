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
      var test = await dio.Dio().post('https://api.horaapp.id/api/absensi',
          data: formData, options: options);
      print(test);
      return test;
    } catch (e) {
      print(e.toString());
      return [];
    }
    // var test = await post(Base.url + Base.absenHadir, headers: header, body);
    // print("INIT TEST: " + test.toString());
    // return test;
  }

  Future pulangPut(param, body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return put(
        '${Base.url}${Base.absenPulang}?id=${param['id']}&tanggal=${param['tanggal']}',
        headers: header,
        body);
  }

  Future izinPost(body) {
    var tokens = box.read(Base.token);
    final header = {'Authorization': '$tokens'};
    return post(Base.url + Base.absenIzin, headers: header, body);
  }
}
