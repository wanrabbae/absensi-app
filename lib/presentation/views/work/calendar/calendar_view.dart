import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_tile.dart';

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
    return RefreshIndicator.adaptive(
      onRefresh: _onRefresh,
      child: BlocBuilder<WorkCubit, WorkState>(
        buildWhen: (previous, current) =>
            previous.selectedDate != current.selectedDate,
        builder: (context, state) {
          final now = DateTime.now().copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            microsecond: 0,
            millisecond: 0,
          );
          final d = state.selectedDate;
          final start = DateTime(d.year, d.month, 1);
          final end = DateTime(d.year, d.month + 1, 1)
              .subtract(const Duration(days: 1));
          final length = end.difference(start).inDays;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final date = start.add(Duration(days: index));
              return CalendarTileView(
                date: date,
                active: now.isAtSameMomentAs(date),
              );
            },
            itemCount: length,
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async {}

  @override
  bool get wantKeepAlive => true;
}
