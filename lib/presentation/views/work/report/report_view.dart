import 'package:app/data/models/laporan/laporan.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'report_tile_view.dart';

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

    final child = BlocBuilder<WorkCubit, WorkState>(
      buildWhen: (previous, current) =>
      previous.laporanError != current.laporanError ||
          previous.laporanList != current.laporanList,
      builder: (context, state) {
        final data = state.laporanList;
        final error = state.laporanError;

        if (data == null && error == null) {
          return const Center(child: LoadingAnimation());
        }

        if (error != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/report.webp',
              title: tr('menu_work_report'),
              subtitle: error,
            ),
          );
        }

        if (data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/report.webp',
              title: tr('menu_work_report'),
              subtitle: tr('menu_work_report_empty'),
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final Laporan laporan = data[index];
            return ReportTileView(laporan, onTap: () {
              Get.toNamed(RouteName.klaimDetail, arguments: laporan);
            });
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
    return cubit.getLaporan();
  }

  @override
  bool get wantKeepAlive => true;
}
