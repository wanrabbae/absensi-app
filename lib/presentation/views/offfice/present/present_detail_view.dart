import 'package:app/core/themes.dart';
import 'package:app/views/home/components/appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'caller/caller_view.dart';
import 'checkin/present_checkin_view.dart';
import 'checkout/present_checkout_view.dart';
import 'location/location_log_view.dart';

class PresentDetailView extends StatelessWidget {
  const PresentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: HoraAppBar(
          context,
          title: Text(tr('detail_present_title')),
          bottom: _buildBottomAppBar(),
        ),
        body: const TabBarView(
          children: [
            CallerView(),
            PresentCheckInView(),
            LocationLogView(),
            PresentCheckOutView(),
          ],
        ),
      ),
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
        Tab(text: tr('detail_present_tab_caller')),
        Tab(text: tr('detail_present_tab_check_in')),
        Tab(text: tr('detail_present_tab_location')),
        Tab(text: tr('detail_present_tab_check_out')),
      ],
    );
  }
}
