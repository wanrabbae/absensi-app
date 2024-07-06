import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/views/offfice/office_screen.dart';
import 'package:app/presentation/views/work/work_screen.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_navigation_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
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
        ..getProfile()
        ..getCompany()
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
          BlocProvider(
            create: (context) {
              final app = context.read<AppCubit>();
              return OfficeCubit(
                context.read(),
                user: app.state.currentUser,
                company: app.state.company,
              );
            },
            child: const DefaultTabController(length: 4, child: OfficeScreen()),
          ),
          const HomeSearchScreen(),
          BlocProvider(
            create: (context) {
              final app = context.read<AppCubit>();
              return WorkCubit(
                context.read(),
                app.state.currentUser!,
              );
            },
            child: const DefaultTabController(length: 3, child: WorkScreen()),
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: DashboardNavigationBar(tabController: tabController),
    );
  }
}
