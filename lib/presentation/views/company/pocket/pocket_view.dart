import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PocketView extends StatefulWidget {
  const PocketView({super.key});

  @override
  State<PocketView> createState() => _PocketViewState();
}

class _PocketViewState extends State<PocketView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
      child: SimpleEmptyView(
        title: tr('company_tab_pocket_not_registered'),
        button: HoraButton(
          onPressed: () {},
          child: Text(tr('company_tab_pocket_not_registered_action_button')),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
