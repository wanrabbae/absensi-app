import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class ReimburseView extends StatefulWidget {
  const ReimburseView({super.key});

  @override
  State<ReimburseView> createState() => _ReimburseViewState();
}

class _ReimburseViewState extends State<ReimburseView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
      child: EmptyView(
        image: 'assets/icons/illustrations/reimburse.webp',
        title: tr('menu_work_reimburse'),
        subtitle: tr('menu_work_reimburse_empty'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
