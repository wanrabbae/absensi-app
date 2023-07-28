import 'package:app/global_resource.dart';
import 'package:app/views/absensi/absensi_izin_downloaded_screen.dart';
import 'package:app/views/absensi/absensi_pulang_screen.dart';
import 'package:app/views/absensi/absensi_screen2.dart';
import 'package:app/views/home/company_full_screen.dart';
import 'package:app/views/home/hadir_result_location_screen.dart';
import 'package:app/views/home/hadir_result_selfie_screen.dart';
import 'package:app/views/home/main_screen.dart';

class Routes {
  static final pages = [
//Start Splash
    GetPage(name: RouteName.splash, page: () => const SplashScreen()),
//End Splash

//Start Tutorial
    GetPage(name: RouteName.tutorial, page: () => const TutorialScreen()),
//End Tutorial

//Start Greeting
    GetPage(name: RouteName.greeting, page: () => const GreetingScreen()),
//End Greeting

//Start Auth
    //Login
    GetPage(name: RouteName.login, page: () => const LoginScreen()),
    //Login Otp
    GetPage(name: RouteName.otpLogin, page: () => const VerifyOtpScreen()),
//End Auth

//Start Home
    //Home
    GetPage(
        name: RouteName.home,
        page: () => MainScreen(
              index: Get.arguments ?? 0,
            )),
    //Home
    GetPage(name: RouteName.homeSearch, page: () => const HomeSearchScreen()),
    //Home Undangan
    GetPage(
        name: RouteName.homeUndangan, page: () => const HomeUndanganScreen()),
    GetPage(
        name: RouteName.companyFullScreen,
        page: () => const CompanyFullScreen()),
    GetPage(
        name: RouteName.hasilHadirFullScreen,
        page: () => const HasilHadirScreen()),
    GetPage(
        name: RouteName.hasilLocationFullScreen,
        page: () => const HadirLocationResult()),
//End Home

//Start Profile
    //Profile
    GetPage(name: RouteName.profile, page: () => const ProfileScreen()),
    //Profile Form
    GetPage(name: RouteName.profileForm, page: () => const ProfileFormScreen()),
    //Profile Ganti Email
    GetPage(
      name: RouteName.profileGantiemail,
      page: () => const ProfileGantiemailOtpScreen(),
    ),
    //Profile Ganti Otp
    GetPage(
      name: RouteName.profileGantiemailOtp,
      page: () => const ProfileGantiemailScreen(),
    ),
//End Profile

//Start Absensi
    //Absen
    GetPage(name: RouteName.absen, page: () => const AbsensiScreen()),
    GetPage(
        name: RouteName.absenPulangView,
        page: () => const AbsensiPulangScreenView()),
    GetPage(name: RouteName.absenViewMode, page: () => AbsensiScreenView()),
    //Izin
    GetPage(name: RouteName.absenIzin, page: () => AbsensiIzinScreen()),
    GetPage(
        name: RouteName.absenIzinDownloaded,
        page: () => const AbsensiIzinDownloadedScreen()),
//End Absensi

//Start WebView
    GetPage(name: RouteName.webview, page: () => const WebviewScreen()),
//End WebView
  ];
}
