import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
      child: EmptyView(
        image: 'assets/icons/illustrations/report.webp',
        title: tr('menu_work_report'),
        subtitle: tr('menu_work_report_empty'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
