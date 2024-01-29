//Package Global
//End Webview

//Views End

import 'package:app/data/source/notification/push_notif_api_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'controllers/app/app_cubit.dart';
import 'data/source/firebase/firebase_service.dart';
import 'firebase_options.dart';
import 'helpers/base.dart';
import 'services/push_notification_service.dart';

export 'dart:async';
export 'dart:convert';
export 'dart:io' hide HeaderValue;

export 'package:app/components/component_custom.dart';

//Components
export 'package:app/components/component_modal.dart';
export 'package:app/components/dialog_permission.dart';

//Controller
export 'package:app/controllers/absen_controller.dart';
export 'package:app/controllers/home_controller.dart';
export 'package:app/controllers/login_controller.dart';
export 'package:app/controllers/profile_controller.dart';
export 'package:app/controllers/splash_controller.dart';

//Helpers
export 'package:app/helpers/base.dart';
export 'package:app/helpers/color_scheme.dart';
export 'package:app/helpers/constant.dart';
export 'package:app/helpers/main_theme.dart';
export 'package:app/helpers/timer.dart';
//Models

//Routes
export 'package:app/routes/routes_pages.dart';

//Services
export 'package:app/services/absensi_services.dart';
export 'package:app/services/auth_services.dart';
export 'package:app/services/home_services.dart';
export 'package:app/services/profile_services.dart';

// izin
export 'package:app/views/absensi/absensi_izin_screen.dart';
//End Profile

//Start Absen
// absen
export 'package:app/views/absensi/absensi_screen.dart';
//End Splash

//Start Auth
//Login
export 'package:app/views/auth/login_screen.dart';

//Otp
export 'package:app/views/auth/verify_otp_screen.dart';
//End Tutorial

//Start splash
export 'package:app/views/greeting/greeting_screen.dart';
//End Auth

//Start Home
//main
// export 'package:app/views/home/home_main_screen.dart';
//index
export 'package:app/views/home/home_screen.dart';

//search
export 'package:app/views/home/home_search_screen.dart';

//undangan
export 'package:app/views/home/home_undangan_screen.dart';

// Update & Delete
export 'package:app/views/profile/profile_form_screen.dart';

// Ganti Email Otp
export 'package:app/views/profile/profile_gantiemail_otp_screen.dart';

// Ganti Email
export 'package:app/views/profile/profile_gantiemail_screen.dart';
//End Home

//Start Profile
// view
export 'package:app/views/profile/profile_screen.dart';
//Views Start

//Start splash
export 'package:app/views/splash/splash_screen.dart';
//End Splash

//Start Tutorial
export 'package:app/views/tutorial/tutorial_screen.dart';
//End Absen

//Start Webview
export 'package:app/views/webview/webview_screen.dart';
export 'package:easy_localization/easy_localization.dart' hide TextDirection;
export 'package:file_picker/file_picker.dart';

// import 'package:location/location.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter_feather_icons/flutter_feather_icons.dart';
export 'package:geocoding/geocoding.dart';
export 'package:geolocator/geolocator.dart';
export 'package:get/get.dart';
export 'package:get_storage/get_storage.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart'
    hide AsyncError, ErrorListener;
export 'package:image_picker/image_picker.dart';
export 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
export 'package:webview_flutter/webview_flutter.dart';

final $it = GetIt.instance;
final kDio = Dio();

initialize() async {
  final box = GetStorage();

  if (kDebugMode) {
    final logger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 100,
    );
    kDio.interceptors.add(logger);
  }

  kDio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      final headers = options.headers;
      final token = box.read(Base.token);
      if (!headers.containsKey('Authorization') && token is String) {
        headers['Authorization'] = token;
      }
      handler.next(options.copyWith(headers: headers));
    },
  ));

  final api = ApiService(kDio, baseUrl: Base.url);
  final pushNotificationApi = PushNotificationApiService(
    kDio
      ..options.contentType = Headers.jsonContentType
      ..options.headers = {
        'X-Hora-Api-Key': '019DB7E5-2EA7-4920-A8C5-E7CFF8105FDC',
      },
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  $it
    ..registerLazySingleton(
      () => PushNotificationService()..initializeLocalNotification(),
    )
    ..registerLazySingleton(() => FirebaseService())
    ..registerSingleton(await PackageInfo.fromPlatform())
    ..registerSingleton(box)
    ..registerSingleton(kDio)
    ..registerSingleton(pushNotificationApi)
    ..registerSingleton(api)
    ..registerSingleton(AppCubit(api, pushNotificationApi, box, $it(), $it()));
}
