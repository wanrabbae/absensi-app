import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/company/company_cubit.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/views/offfice/office_screen.dart';
import 'package:app/presentation/views/search/search_screen.dart';
import 'package:app/presentation/views/work/work_screen.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/loading.dart';
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
      context.read<CompanyCubit>().getCompany();
      context.read<AppCubit>()
        ..getProfile()
        ..checkForUpdates(context.locale.countryCode!).then((result) {
          if (result.canUpdate == true) {
            Get.toNamed(RouteName.appUpdate, arguments: result);
          }
        })
        ..updateTokenFcm()
        ..getCameras()
        ..getAllowLocationAlwaysPermission();

      context.read<AppCubit>().isFakeGpsEnabled().then((isFakeGpsEnabled) {
        if (isFakeGpsEnabled) {
          showHoraCustomBottomSheet(
            context,
            isDismissible: false,
            disableBackButton: true,
            title: tr('fake_gps_title'),
            content: Text(tr('fake_gps_description')),
            button: HoraButton(
              onPressed: () {
                Navigator.pop(context);
                SystemNavigator.pop();
              },
              child: Text(tr('fake_gps_button')),
            ),
          );
        }
      });
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
          BlocBuilder<AppCubit, AppState>(
            buildWhen: (previous, current) =>
                previous.currentUser != current.currentUser ||
                previous.company != current.company,
            builder: (context, state) {
              if (state.currentUser == null) {
                return const Center(child: LoadingAnimation());
              }

              return BlocProvider(
                create: (context) {
                  return OfficeCubit(
                    context.read(),
                    user: state.currentUser!,
                    company: state.company,
                  );
                },
                child: const DefaultTabController(
                  length: 4,
                  child: OfficeScreen(),
                ),
              );
            },
          ),
          const SearchScreen(),
          BlocBuilder<AppCubit, AppState>(
            buildWhen: (previous, current) =>
                previous.currentUser != current.currentUser,
            builder: (context, state) {
              final currentUser = state.currentUser;
              if (currentUser == null) {
                return const Center(child: LoadingAnimation());
              }

              return BlocProvider(
                create: (context) {
                  return WorkCubit(context.read(), currentUser);
                },
                child: const DefaultTabController(
                  length: 3,
                  child: WorkScreen(),
                ),
              );
            },
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: DashboardNavigationBar(tabController: tabController),
    );
  }
}
