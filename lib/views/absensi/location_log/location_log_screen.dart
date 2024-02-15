import 'package:app/components/empty_view.dart';
import 'package:app/controllers/live_location_log/live_location_log_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:app/views/absensi/location_log/location_log_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class LocationLogScreen extends StatefulWidget {
  const LocationLogScreen({super.key});

  @override
  State<LocationLogScreen> createState() => _LocationLogScreenState();
}

class _LocationLogScreenState extends State<LocationLogScreen> {
  final screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LiveLocationLogCubit>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveLocationLogCubit>();
    final attendance = cubit.attendance;
    final img = attendance.fotoKaryawan;
    final name = attendance.namaKaryawan ?? '';

    final child = Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            img != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(changeUrlImage(img)),
                    radius: 15,
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/logo/hora.png'),
                    radius: 15,
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<LiveLocationLogCubit, LiveLocationLogState>(
            builder: (context, state) {
              final showData = state.data != null &&
                  state.data!.isNotEmpty &&
                  state.error == null;
              return IconButton(
                onPressed: !showData
                    ? null
                    : () async {
                        final pixelRatio =
                            MediaQuery.of(context).devicePixelRatio;
                        final path =
                            (await getApplicationDocumentsDirectory()).path;
                        final fileName =
                            '${DateTime.now().microsecondsSinceEpoch}.png';
                        screenshotController
                            .captureAndSave(
                          path,
                          fileName: fileName,
                          pixelRatio: pixelRatio,
                        )
                            .then((savePath) {
                          if (savePath != null) {
                            AwesomeNotificationService()
                                .showNotificationCapture(path: savePath);
                          }
                        }).catchError((onError) {
                          if (kDebugMode) {
                            print(onError);
                          }
                        });
                      },
                icon: Image.asset(
                  'assets/icons/ic_screen_shot.png',
                  color: colorBluePrimary,
                  height: 24,
                  width: 24,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
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

    return Screenshot(
      controller: screenshotController,
      child: child,
    );
  }
}
