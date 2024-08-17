import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({super.key});

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
      child: EmptyView(
        image: 'assets/icons/illustrations/agenda.webp',
        title: tr('menu_work_agenda'),
        subtitle: tr('menu_work_agenda_empty'),
      ),
    );
  }

  Future<void> _onRefresh() async {}

  @override
  bool get wantKeepAlive => true;
}
