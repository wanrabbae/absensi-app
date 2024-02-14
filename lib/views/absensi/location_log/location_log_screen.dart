import 'package:app/components/component_modal.dart';
import 'package:app/components/empty_view.dart';
import 'package:app/controllers/live_location_log/live_location_log_cubit.dart';
import 'package:app/views/absensi/location_log/location_log_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationLogScreen extends StatefulWidget {
  const LocationLogScreen({super.key});

  @override
  State<LocationLogScreen> createState() => _LocationLogScreenState();
}

class _LocationLogScreenState extends State<LocationLogScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LiveLocationLogCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LiveLocationLogCubit, LiveLocationLogState>(
        builder: (context, state) {
          final data = state.data;
          final error = state.error;

          if (data == null && error == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (error != null) {
            return const EmptyView(
              image: 'assets/icons/absen-ilus.webp',
              title: '',
              subtitle: '',
            );
          }

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  tr('location_history'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              for (int i = 0; i < data!.length; i++)
                LocationLogTile(
                  data[i],
                  first: i == 0,
                  second: i == 1,
                  last: i == data.length - 1,
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        color: colorBlueOpacity,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            tr('live_location_log_footer'),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
