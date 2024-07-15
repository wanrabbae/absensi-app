import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/views/offfice/present/present_tile.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresentView extends StatelessWidget {
  const PresentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.attendance.listAttendance !=
              current.attendance.listAttendance ||
          previous.attendance.error != current.attendance.error,
      builder: (context, state) {
        final data = state.attendance.listAttendance;
        final error = state.attendance.error;
        final user = state.user;

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
                    image: 'assets/icons/illustrations/present.webp',
                    title: tr('present'),
                    subtitle: error,
                  ),
                );
              }

              if (data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
                  child: EmptyView(
                    image: 'assets/icons/illustrations/present.webp',
                    title: tr('present'),
                    subtitle: tr('present_empty'),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final attendance = data[index];
                  return PresentListTile(
                    data: attendance,
                    isCurrent: user.idkaryawan == attendance.idKaryawan,
                  );
                },
                itemCount: data.length,
              );
            },
          ),
          onRefresh: () => context.read<OfficeCubit>().reloadAttendance(),
        );
      },
    );
  }
}
