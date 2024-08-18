import 'package:app/presentation/blocs/company/company_cubit.dart';
import 'package:app/presentation/views/company/pocket/pocket_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'company_appbar.dart';
import 'staff/staff_view.dart';
import 'statistic/statistic_view.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CompanyCubit>().getStaffList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const CompanyAppBar(),
              const CompanyTabBar(),
            ];
          },
          body: const TabBarView(
            children: [
              PocketView(),
              StaffView(),
              StatisticView(),
            ],
          ),
        ),
      ),
    );
  }
}
