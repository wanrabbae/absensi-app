import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:app/views/dashboard/dashboard_navigation_bar.dart';
import 'package:app/views/offfice/office_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  String? get activeAttendanceDate {
    if (Get.arguments is String) {
      return Get.arguments;
    }
    return null;
  }

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: Get.arguments is int ? Get.arguments as int : 0,
    );

    $it<PushNotificationService>().requestPermission();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>()
        ..checkForUpdates(context.locale.countryCode!).then((result) {
          if (result.canUpdate == true) {
            Get.toNamed(RouteName.appUpdate, arguments: result);
          }
        })
        ..updateTokenFcm()
        ..getAllowLocationAlwaysPermission();
    });

    tabController.addListener(() {
      Tooltip.dismissAllToolTips();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const OfficeScreen(),
          const HomeSearchScreen(),
          activeAttendanceDate != null
              ? HomeScreen(activeAttendanceDate: activeAttendanceDate)
              : const HomeScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: DashboardNavigationBar(tabController: tabController),
    );
  }
}
