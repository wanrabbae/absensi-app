import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:app/presentation/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reimburse_tile_view.dart';

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

    final child = BlocBuilder<WorkCubit, WorkState>(
      buildWhen: (previous, current) =>
          previous.klaimError != current.klaimError ||
          previous.klaimList != current.klaimList,
      builder: (context, state) {
        final data = state.klaimList;
        final error = state.klaimError;

        if (data == null && error == null) {
          return const Center(child: LoadingAnimation());
        }

        if (error != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/reimburse.webp',
              title: tr('menu_work_reimburse'),
              subtitle: error,
            ),
          );
        }

        if (data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            child: EmptyView(
              image: 'assets/icons/illustrations/reimburse.webp',
              title: tr('menu_work_reimburse'),
              subtitle: tr('menu_work_reimburse_empty'),
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final klaim = data[index];
            return ReimburseTileView(klaim, onTap: () {
              Get.toNamed(RouteName.klaimDetail, arguments: klaim);
            });
          },
          itemCount: data.length,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
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
    return cubit.getReimbursement();
  }

  @override
  bool get wantKeepAlive => true;
}
