import 'package:app/controllers/klaim/form/klaim_form_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/absensi/absensi_izin_downloaded_screen.dart';
import 'package:app/views/absensi/absensi_pulang_screen.dart';
import 'package:app/views/absensi/absensi_screen2.dart';
import 'package:app/views/home/company_full_screen.dart';
import 'package:app/views/home/company_screen.dart';
import 'package:app/views/home/hadir_result_location_screen.dart';
import 'package:app/views/home/hadir_result_selfie_screen.dart';
import 'package:app/views/home/klaim/klaim_form.dart';
import 'package:app/views/home/main_screen.dart';
import 'package:app/views/home/stop_working_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static final pages = [
    // region Splash
    GetPage(name: RouteName.splash, page: () => const SplashScreen()),
    // endregion Splash

    // region Tutorial
    GetPage(name: RouteName.tutorial, page: () => const TutorialScreen()),
    // endregion Tutorial

    // region Greeting
    GetPage(name: RouteName.greeting, page: () => const GreetingScreen()),
    // endregion Greeting

    // region Auth
    // Login
    GetPage(name: RouteName.login, page: () => const LoginScreen()),
    // Login Otp
    GetPage(name: RouteName.otpLogin, page: () => const VerifyOtpScreen()),
    // endregion Auth

    // region Home
    // Home
    GetPage(name: RouteName.home, page: () => const MainScreen()),
    // Home
    GetPage(name: RouteName.homeSearch, page: () => const HomeSearchScreen()),
    // Home Undangan
    GetPage(
      name: RouteName.homeUndangan,
      page: () => const HomeUndanganScreen(),
    ),
    GetPage(
      name: RouteName.companyFullScreen,
      page: () => const CompanyFullScreen(),
    ),
    GetPage(name: RouteName.companyScreen, page: () => const CompanyScreen()),
    GetPage(name: RouteName.stopWorking, page: () => const StopWorkingScreen()),
    GetPage(
      name: RouteName.hasilHadirFullScreen,
      page: () => const HasilHadirScreen(),
    ),
    GetPage(
      name: RouteName.hasilLocationFullScreen,
      page: () => const HadirLocationResult(),
    ),
    // endregion Home

    // region Profile
    // Profile
    GetPage(name: RouteName.profile, page: () => const ProfileScreen()),
    // Profile Form
    GetPage(name: RouteName.profileForm, page: () => const ProfileFormScreen()),
    // Profile Ganti Email
    GetPage(
      name: RouteName.profileGantiemail,
      page: () => const ProfileGantiemailOtpScreen(),
    ),
    // Profile Ganti Otp
    GetPage(
      name: RouteName.profileGantiemailOtp,
      page: () => const ProfileGantiemailScreen(),
    ),
    // endregion Profile

    // region Absensi
    // Absen
    GetPage(name: RouteName.absen, page: () => const AbsensiScreen()),
    GetPage(
      name: RouteName.absenPulangView,
      page: () => const AbsensiPulangScreenView(),
    ),
    GetPage(
      name: RouteName.absenViewMode,
      page: () => const AbsensiScreenView(),
    ),
    // Izin
    GetPage(name: RouteName.absenIzin, page: () => const AbsensiIzinScreen()),
    GetPage(
      name: RouteName.absenIzinDownloaded,
      page: () => const AbsensiIzinDownloadedScreen(),
    ),
    // endregion Absensi

    // region WebView
    GetPage(name: RouteName.webview, page: () => const WebviewScreen()),
    // endregion WebView

    // region Klaim
    GetPage(
      name: RouteName.klaimForm,
      page: () {
        print(Get.arguments.runtimeType);
        return BlocProvider(
          create: (context) => KlaimFormCubit(api: $it(), file: Get.arguments),
          child: const KlaimForm(),
        );
      },
    ),
    // endregion
  ];
}
