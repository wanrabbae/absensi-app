import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/views/offfice/report/report_tile.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SickView extends StatelessWidget {
  const SickView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.sick.listSick != current.sick.listSick ||
          previous.sick.error != current.sick.error,
      builder: (context, state) {
        final data = state.sick.listSick;
        final error = state.sick.error;

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
                    image: 'assets/icons/illustrations/sick.webp',
                    title: tr('sick'),
                    subtitle: error,
                  ),
                );
              }

              if (data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
                  child: EmptyView(
                    image: 'assets/icons/illustrations/sick.webp',
                    title: tr('sick'),
                    subtitle: tr('sick_empty'),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  final sick = data[index];
                  return ReportListTile(data: sick);
                },
                itemCount: data.length,
              );
            },
          ),
          onRefresh: () => context.read<OfficeCubit>().getCurrentSickList(),
        );
      },
    );
  }
}
