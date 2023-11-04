import 'package:app/data/models/company.dart';
import 'package:app/data/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService with $Company, $Profile {
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
