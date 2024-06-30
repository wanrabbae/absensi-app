import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/views/offfice/office_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'leave/leave_view.dart';
import 'office_fab.dart';
import 'permit/permit_view.dart';
import 'present/present_view.dart';
import 'sick/sick_view.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({super.key});

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OfficeCubit>().reloadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: OfficeAppBar(context, bottom: _buildBottomAppBar()),
      body: const TabBarView(
        children: [
          PresentView(),
          LeaveView(),
          PermitView(),
          SickView(),
        ],
      ),
      floatingActionButton: const OfficeFAB(),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
        Tab(text: tr('present')),
        Tab(text: tr('leave')),
        Tab(text: tr('permit')),
        Tab(text: tr('sick')),
      ],
    );
  }
}
