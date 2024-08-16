import 'package:app/core/themes.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/views/work/work_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar/calendar_view.dart';
import 'reimburse/reimburse_view.dart';
import 'report/report_view.dart';
import 'work_fab.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WorkCubit>()
        ..getReimbursement()
        ..getLaporan();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: WorkAppBar(context, bottom: _buildBottomAppBar()),
      body: const TabBarView(
        children: [
          CalendarView(),
          ReportView(),
          ReimburseView(),
        ],
      ),
      floatingActionButton: const WorkFAB(),
    );
  }

  PreferredSizeWidget _buildBottomAppBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      indicatorColor: colorBluePrimary,
      tabs: [
        Tab(text: tr('menu_work_calendar')),
        Tab(text: tr('menu_work_report')),
        Tab(text: tr('menu_work_reimburse')),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
