import 'package:app/components/component_modal.dart';
import 'package:app/components/empty_view.dart';
import 'package:app/controllers/home/home_cubit.dart';
import 'package:app/views/home/klaim/klaim_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KlaimView extends StatelessWidget {
  const KlaimView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.klaimError != current.klaimError ||
          previous.klaimList != current.klaimList,
      builder: (context, state) {
        final data = state.klaimList;
        final error = state.klaimError;

        if (data == null && error == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (error != null) {
          return Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
            child: EmptyView(
              image: 'assets/icons/klaim-ilus.png',
              title: 'Klaim',
              subtitle: error,
            ),
          );
        }

        if (data!.isEmpty) {
          return Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
            child: const EmptyView(
              image: 'assets/icons/klaim-ilus.png',
              title: 'Klaim',
              subtitle:
                  'Fitur ini akan mencatat, menyimpan dan menampilkan detail klaim anda secara berkala.',
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: onRefresh,
          color: colorBluePrimary2,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final klaim = data[index];
              return KlaimTileView(klaim, onTap: () {});
            },
            itemCount: data.length,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
          ),
        );
      },
    );
  }

  Future<void> onRefresh() async {}
}
