//Package Global
export 'dart:async';
export 'dart:convert';
export 'package:get/get.dart';
export 'dart:io' hide HeaderValue;
// import 'package:location/location.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:geolocator/geolocator.dart';
export 'package:file_picker/file_picker.dart';
export 'package:get_storage/get_storage.dart';
export 'package:image_picker/image_picker.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:geocoding/geocoding.dart';
export 'package:permission_handler/permission_handler.dart' hide ServiceStatus;
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';
export 'package:flutter_feather_icons/flutter_feather_icons.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart'
    hide AsyncError, ErrorListener;
export 'package:easy_localization/easy_localization.dart' hide TextDirection;

//Components
export 'package:app/components/component_modal.dart';
export 'package:app/components/component_custom.dart';
export 'package:app/components/component_custom_navbar.dart';
export 'package:app/helpers/timer.dart';
export 'package:app/components/dialog_detect_location.dart';
export 'package:app/components/dialog_gender.dart';
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
export 'package:app/data/data_helper.dart';

//Models

//Routes
export 'package:app/routes/routes_pages.dart';

//Services
export 'package:app/services/absensi_services.dart';
export 'package:app/services/auth_services.dart';
export 'package:app/services/home_services.dart';
export 'package:app/services/profile_services.dart';

//Views Start

//Start splash
export 'package:app/views/splash/splash_screen.dart';
//End Splash

//Start Tutorial
export 'package:app/views/tutorial/tutorial_screen.dart';
//End Tutorial

//Start splash
export 'package:app/views/greeting/greeting_screen.dart';
//End Splash

//Start Auth
//Login
export 'package:app/views/auth/login_screen.dart';
//Otp
export 'package:app/views/auth/verify_otp_screen.dart';
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
//End Home

//Start Profile
// view
export 'package:app/views/profile/profile_screen.dart';
// Update & Delete
export 'package:app/views/profile/profile_form_screen.dart';
// Ganti Email
export 'package:app/views/profile/profile_gantiemail_screen.dart';
// Ganti Email Otp
export 'package:app/views/profile/profile_gantiemail_otp_screen.dart';
//End Profile

//Start Absen
// absen
export 'package:app/views/absensi/absensi_screen.dart';
// izin
export 'package:app/views/absensi/absensi_izin_screen.dart';
//End Absen

//Start Webview
export 'package:app/views/webview/webview_screen.dart';
//End Webview

//Views End