import 'package:app/data/models/absence.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class OfficeFAB extends StatelessWidget {
  const OfficeFAB({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.index) {
          case 0:
            return const PresenceFAB();
          default:
            return const AddFAB();
        }
      },
    );
  }
}

class PresenceFAB extends StatefulWidget {
  const PresenceFAB({super.key});

  @override
  State<PresenceFAB> createState() => _PresenceFABState();
}

class _PresenceFABState extends State<PresenceFAB> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  final rxButtonEnabled = ValueNotifier(true);

  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        const SizedBox(width: 32),
        Expanded(
          child: AnimatedBuilder(
            animation: rxButtonEnabled,
            builder: (context, child) {
              final buttonEnabled = rxButtonEnabled.value;

              Widget child = HoraButton(
                onPressed: buttonEnabled
                    ? () {
                        Get.find<HomeController>().absensi(context);
                      }
                    : null,
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_bottom),
                    Expanded(
                      child: StreamBuilder(
                        stream: stopWatchTimer.rawTime,
                        builder: (context, snapshot) {
                          final value = snapshot.data;
                          String displayTime = '00 : 00 : 00';

                          if (value != null) {
                            displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              milliSecond: false,
                              hoursRightBreak: ' : ',
                              minuteRightBreak: ' : ',
                            );
                          }

                          return Text(
                            displayTime,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          );
                        },
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              );

              if (!buttonEnabled) {
                child = GestureDetector(
                  onTap: () {
                    customSnackbar1(tr('snackbar_already_present'));
                  },
                  child: child,
                );
              }

              return child;
            },
          ),
        ),
      ],
    );

    return BlocListener<OfficeCubit, OfficeState>(
      listenWhen: (previous, current) =>
          previous.attendance.currentAttendance !=
          current.attendance.currentAttendance,
      listener: (context, state) {
        _handleTodayAttendanceTimer(state.attendance.currentAttendance);
      },
      child: child,
    );
  }

  _handleTodayAttendanceTimer(Absence? currentAttendance) {
    if (currentAttendance == null) {
      rxButtonEnabled.value = true;
      return;
    }

    if (currentAttendance.isCheckIn && currentAttendance.isCheckOut) {
      rxButtonEnabled.value = false;
      return;
    }

    stopWatchTimer.setPresetTime(
      mSec: DateTime.now()
          .difference(currentAttendance.waktuCheckIn!)
          .inMilliseconds,
    );
    stopWatchTimer.onStartTimer();
  }
}

class AddFAB extends StatelessWidget {
  const AddFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: colorBluePrimary2,
      foregroundColor: Colors.white,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }
}
