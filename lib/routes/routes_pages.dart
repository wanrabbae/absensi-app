import 'package:app/global_resource.dart';

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
    GetPage(name: RouteName.home, page: () => const HomeScreen()),
    //Home
    GetPage(name: RouteName.homeSearch, page: () => const HomeSearchScreen()),
    //Home Undangan
    GetPage(
        name: RouteName.homeUndangan, page: () => const HomeUndanganScreen()),
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
    //Izin
    GetPage(name: RouteName.absenIzin, page: () => const AbsensiIzinScreen()),
//End Absensi

//Start WebView
    GetPage(name: RouteName.webview, page: () => const WebviewScreen()),
//End WebView
  ];
}
