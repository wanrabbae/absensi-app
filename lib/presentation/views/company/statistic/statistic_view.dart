import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
      child: SimpleEmptyView(
        title: tr('company_tab_statistic_not_found'),
        button: HoraButton(
          onPressed: () {},
          child: Text(tr('company_tab_statistic_not_found_action_button')),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
