import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/appbar.dart';

import 'leave/leave_view.dart';
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HoraAppBar(context, bottom: _buildBottomAppBar()),
      body: const TabBarView(
        children: [
          PresentView(),
          LeaveView(),
          PermitView(),
          SickView(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  PreferredSizeWidget _buildBottomAppBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
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
