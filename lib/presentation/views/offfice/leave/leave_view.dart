import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/views/offfice/permit/report_tile.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveView extends StatelessWidget {
  const LeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.leave.listLeave != current.leave.listLeave ||
          previous.leave.error != current.leave.error,
      builder: (context, state) {
        final data = state.leave.listLeave;
        final error = state.leave.error;

        if (data == null && error == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return RefreshIndicator.adaptive(
          child: Builder(
            builder: (context) {
              if (error != null) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
                  child: EmptyView(
                    image: 'assets/icons/illustrations/leave.webp',
                    title: tr('leave'),
                    subtitle: error,
                  ),
                );
              }

              if (data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
                  child: EmptyView(
                    image: 'assets/icons/illustrations/leave.webp',
                    title: tr('leave'),
                    subtitle: tr('leave_empty'),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final permit = data[index];
                  return ReportListTile(data: permit);
                },
                itemCount: data.length,
              );
            },
          ),
          onRefresh: () => context.read<OfficeCubit>().getCurrentLeaveList(),
        );
      },
    );
  }
}
