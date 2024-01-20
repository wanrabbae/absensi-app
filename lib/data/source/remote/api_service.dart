import 'dart:io';

import 'package:app/data/models/absence.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/data/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService with $Company, $Profile, $Attendance, $Reimburse {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
}

mixin $Company {
  @GET('api/profile/home-company')
  Future<List<Company>> getCompany({
    @Query("email") required String email,
  });

  @PUT('api/profile/like')
  Future<String> toggleLikeUnlike({
    @Query("karyawanid") required String karyawanId,
    @Query("perusahaanid") required String perusahaanId,
  });

  @PUT('api/profile/delete')
  Future<String> stopWorking({
    @Query("email") required String email,
  });
}

mixin $Profile {
  @GET('api/profile/viewprofile')
  Future<Profile> getProfile({
    @Query("email") required String email,
  });
}

mixin $Attendance {
  @GET('api/absensi/indie')
  Future<List<Absence>> getAttendance({
    @Query("idkaryawan") required String idkaryawan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });
}

mixin $Reimburse {
  @GET('api/absensi/ReimbView')
  Future<List<Klaim>> getReimburse({
    @Query("idperusahaan") required String idPerusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @POST('api/absensi/Reimb')
  Future<dynamic> submitReimburse({
    @Part(name: "IDKaryawan") required String idKaryawan,
    @Part(name: "NamaKaryawan") required String namaKaryawan,
    @Part(name: "Keterangan") required String keterangan,
    @Part(name: "IDPerusahaan") required String idPerusahaan,
    @Part(name: "NamaPerusahaan") required String namaPerusahaan,
    @Part(name: "File", contentType: "image/*") required File file,
  });
}
