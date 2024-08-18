import 'package:app/core/themes.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class StaffView extends StatefulWidget {
  const StaffView({super.key});

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
        child: SimpleEmptyView(
          title: tr('company_tab_staff_not_found'),
          button: HoraButton(
            onPressed: () {},
            child: Text(tr('company_tab_staff_not_found_action_button')),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorBluePrimary,
        foregroundColor: Colors.white,
        child: const Icon(Boxicons.bx_user_plus),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
