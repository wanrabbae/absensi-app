import 'dart:io';

import 'package:app/data/models/absence.dart';
import 'package:app/data/models/agenda/agenda.dart';
import 'package:app/data/models/auth/verify_otp.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/invitation/invitation.dart';
import 'package:app/data/models/klaim/klaim.dart';
import 'package:app/data/models/laporan/laporan.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/models/report/report.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService
    with
        $Auth,
        $Company,
        $Profile,
        $Attendance,
        $Reimburse,
        $Report,
        $Laporan,
        $Agenda {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
}

mixin $Auth {
  @PUT('api/login/sendlink')
  Future<String> requestEmailOTP({
    @Query("email") required String email,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('api/login/verifyOTP')
  Future<VerifyOTP> verifyEmailOTP({
    @Query("email") required String email,
    @Query("otp") required String otp,
    @CancelRequest() CancelToken? cancelToken,
  });
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

  @POST('api/invite')
  Future<HttpResponse<String>> inviteStaff({
    @Body() required Invitation request,
    @CancelRequest() CancelToken? cancelToken,
  });
}

mixin $Profile {
  @GET('api/profile/viewprofile')
  Future<Profile> getProfile({
    @Query("email") required String email,
  });

  @GET('api/profile/search-company')
  Future<List<Profile>> getKaryawanList({
    @Query("idperusahaan") required String idPerusahaan,
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
    @CancelRequest() CancelToken? cancelToken,
  });

  @PUT('api/absensi/pulang')
  Future<dynamic> checkOut({
    @Query('id') required int id,
    @Part(name: 'NamaKaryawan') required String staffName,
    @Part(name: 'AlamatPulang') required String address,
    @Part(name: 'LatitudePulang') required String latitude,
    @Part(name: 'LongtitudePulang') required String longitude,
    @Part(name: "Foto", contentType: "image/*") required File photo,
    @CancelRequest() CancelToken? cancelToken,
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
    @CancelRequest() CancelToken? cancelToken,
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
  Future<dynamic> submitReport({
    @Part(name: "IDKaryawan") required String idKaryawan,
    @Part(name: "NamaKaryawan") required String namaKaryawan,
    @Part(name: "Keterangan") required String description,
    @Part(name: "Ijin") required String type,
    @Part(name: "DokumenIjin", contentType: "image/*") required File file,
    @Part(name: "IDPerusahaan") required String idPerusahaan,
    @Part(name: "NamaPerusahaan") required String namaPerusahaan,
    @CancelRequest() CancelToken? cancelToken,
  });
}

mixin $Laporan {
  @GET('api/absensi/LapView')
  Future<List<Laporan>> getLaporan({
    @Query("idperusahaan") required String idPerusahaan,
    @Query("tglstart") required String start,
    @Query("tglend") required String end,
  });

  @POST('api/absensi/Laporan')
  Future<dynamic> submitLaporan({
    @Part(name: "IDKaryawan") required String idKaryawan,
    @Part(name: "NamaKaryawan") required String namaKaryawan,
    @Part(name: "IDPerusahaan") required String idPerusahaan,
    @Part(name: "NamaPerusahaan") required String namaPerusahaan,
    @Part(name: "File", contentType: "image/*") required File file,
    @Part(name: "Keterangan") required String keterangan,
    @Part(name: "LocLat") required String latitude,
    @Part(name: "LocLang") required String longitude,
    @Part(name: "Lokasi") required String lokasi,
    @Part(name: "Tag") required String tag,
    @CancelRequest() CancelToken? cancelToken,
  });
}

mixin $Agenda {
  @GET('api/absensi/viewKal')
  Future<List<Agenda>> getAgenda({
    @Query("idperusahaan") required String idPerusahaan,
  });

  @POST('api/absensi/kalender')
  Future<HttpResponse<dynamic>> submitAgenda({
    @Query("karyawanid") required String idKaryawan,
    @Body() required AgendaMutable request,
    @CancelRequest() CancelToken? cancelToken,
  });
}
