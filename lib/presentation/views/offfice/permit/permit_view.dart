import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../report/report_tile.dart';

class PermitView extends StatelessWidget {
  const PermitView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.permit.listPermit != current.permit.listPermit ||
          previous.permit.error != current.permit.error,
      builder: (context, state) {
        final data = state.permit.listPermit;
        final error = state.permit.error;

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
                    image: 'assets/icons/illustrations/permit.webp',
                    title: tr('permit'),
                    subtitle: error,
                  ),
                );
              }

              if (data!.isEmpty) {
                return Padding(padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
                  child: EmptyView(
                    image: 'assets/icons/illustrations/permit.webp',
                    title: tr('permit'),
                    subtitle: tr('permit_empty'),
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
          onRefresh: () => context.read<OfficeCubit>().getCurrentPermitList(),
        );
      },
    );
  }
}
