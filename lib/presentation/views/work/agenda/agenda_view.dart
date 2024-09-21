import 'package:app/data/models/agenda/agenda.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'agenda_tile_view.dart';

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

    final child = BlocBuilder<WorkCubit, WorkState>(
      buildWhen: (previous, current) =>
      previous.agendaError != current.agendaError ||
          previous.agendaList != current.agendaList,
      builder: (context, state) {
        final data = state.agendaList;
        final error = state.agendaError;

        if (data == null && error == null) {
          return const Center(child: LoadingAnimation());
        }

        if (error != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/agenda.webp',
              title: tr('menu_work_agenda'),
              subtitle: error,
            ),
          );
        }

        if (data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/agenda.webp',
              title: tr('menu_work_agenda'),
              subtitle: tr('menu_work_agenda_empty'),
            ),
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            final Agenda agenda = data[index];
            return AgendaTileView(agenda);
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 0, color: colorDisabled);
          },
          itemCount: data.length,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 72),
        );
      },
    );

    return RefreshIndicator.adaptive(
      onRefresh: () => onRefresh(context),
      color: colorBluePrimary2,
      child: child,
    );
  }

  Future<void> onRefresh(BuildContext context) {
    final cubit = context.read<WorkCubit>();
    return cubit.getAgenda();
  }

  @override
  bool get wantKeepAlive => true;
}
