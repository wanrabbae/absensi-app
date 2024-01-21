import 'dart:async';

import 'package:app/components/component_modal.dart';
import 'package:app/components/empty_view.dart';
import 'package:app/controllers/home/home_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/views/home/klaim/klaim_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Completer<bool>? _completer;

class KlaimView extends StatelessWidget {
  const KlaimView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.klaimError != current.klaimError ||
          previous.klaimList != current.klaimList,
      listener: (context, state) {
        if (_completer != null) {
          _completer!.complete(true);
          _completer = null;
        }
      },
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
              image: 'assets/icons/klaim-ilus.webp',
              title: 'Klaim',
              subtitle: error,
            ),
          );
        }

        if (data!.isEmpty) {
          return Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
            child: const EmptyView(
              image: 'assets/icons/klaim-ilus.webp',
              title: 'Klaim',
              subtitle:
                  'Fitur ini akan mencatat, menyimpan dan menampilkan detail klaim anda secara berkala.',
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => onRefresh(context),
          color: colorBluePrimary2,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final klaim = data[index];
              return KlaimTileView(klaim, onTap: () {
                Get.toNamed(RouteName.klaimDetail, arguments: klaim);
              });
            },
            itemCount: data.length,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 72),
          ),
        );
      },
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    final cubit = context.read<HomeCubit>();
    final idPerusahaan = cubit.state.idPerusahaan!;
    cubit.getDataKlaim(idPerusahaan);

    _completer = Completer();
    await _completer!.future;
  }
}
