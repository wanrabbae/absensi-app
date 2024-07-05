import 'dart:io';

import 'package:app/data/models/absence.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/models/report/report.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService
    with $Company, $Profile, $Attendance, $Reimburse, $Report {
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

  @GET('api/absensi/HomeA')
  Future<List<Absence>> getAttendanceList({
    @Query("idperusahaan") required String idperusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @POST('api/absensi')
  Future<dynamic> checkIn({
    @Part(name: 'IDPerusahaan') required String companyId,
    @Part(name: 'NamaPerusahaan') required String companyName,
    @Part(name: 'IDKaryawan') required String staffId,
    @Part(name: 'NamaKaryawan') required String staffName,
    @Part(name: 'AlamatLoc') required String address,
    @Part(name: 'AlamatLatitude') required String latitude,
    @Part(name: 'AlamatLongtitude') required String longitude,
    @Part(name: "Foto", contentType: "image/*") required File photo,
  });

  @POST('api/absensi/pulang/{id}')
  Future<dynamic> checkOut({
    @Path('id') required int id,
    @Part(name: 'NamaKaryawan') required String staffName,
    @Part(name: 'AlamatPulang') required String address,
    @Part(name: 'LatitudePulang') required String latitude,
    @Part(name: 'LongtitudePulang') required String longitude,
    @Part(name: "Foto", contentType: "image/*") required File photo,
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

mixin $Report {
  @GET('api/absensi/Report')
  Future<String> sendReport({
    @Query("idperusahaan") required String idPerusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
    @Query("emailrep") required String email,
  });

  @GET('api/absensi/ReportIzin')
  Future<String> sendReportIzin({
    @Query("idperusahaan") required String idPerusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
    @Query("emailrep") required String email,
    @Query("Status") required String status,
  });

  @GET('api/absensi/HomeI')
  Future<List<Report>> getPermitList({
    @Query("idperusahaan") required String idperusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @GET('api/absensi/HomeC')
  Future<List<Report>> getLeaveList({
    @Query("idperusahaan") required String idperusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @GET('api/absensi/HomeS')
  Future<List<Report>> getSickList({
    @Query("idperusahaan") required String idperusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @POST('api/absensi/Izin')
  Future<dynamic> submitReport(
      {@Part(name: "IDKaryawan") required String idKaryawan,
      @Part(name: "NamaKaryawan") required String namaKaryawan,
      @Part(name: "Keterangan") required String description,
      @Part(name: "Ijin") required String type,
      @Part(name: "DokumenIjin", contentType: "image/*") required File file,
      @Part(name: "IDPerusahaan") required String idPerusahaan,
      @Part(name: "NamaPerusahaan") required String namaPerusahaan,
      @CancelRequest() CancelToken? cancelToken});
}
