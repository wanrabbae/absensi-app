import 'package:app/global_resource.dart';
import 'package:app/presentation/widgets/empty_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SizedBox.shrink();
  }

  @override
  bool get wantKeepAlive => true;
}
