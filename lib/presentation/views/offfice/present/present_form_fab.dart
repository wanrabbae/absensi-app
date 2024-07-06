import 'package:app/data/models/absence.dart';
import 'package:app/presentation/blocs/office/present/form/present_form_cubit.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PresentFormFAB extends StatefulWidget {
  const PresentFormFAB({super.key});

  @override
  State<PresentFormFAB> createState() => _PresentFormFABState();
}

class _PresentFormFABState extends State<PresentFormFAB> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<PresentFormCubit>();
      final currentAttendance = cubit.state.currentAttendance;
      _handleTodayAttendanceTimer(currentAttendance);
    });
  }

  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 32),
        Expanded(
          child: BlocBuilder<PresentFormCubit, PresentFormState>(
            buildWhen: (previous, current) =>
                previous.currentAttendance != current.currentAttendance,
            builder: (context, state) {
              return HoraButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(Boxicons.bxs_hourglass),
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
                    const Icon(Boxicons.bxs_chevron_right),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _handleTodayAttendanceTimer(Absence? currentAttendance) {
    if (currentAttendance == null) {
      stopWatchTimer.setPresetTime(mSec: 0, add: false);
      stopWatchTimer.onStopTimer();
      return;
    }

    if (currentAttendance.isCheckIn && currentAttendance.isCheckOut) {
      stopWatchTimer.setPresetTime(
        mSec: currentAttendance.waktuCheckOut!
            .difference(currentAttendance.waktuCheckIn!)
            .inMilliseconds,
        add: false,
      );
      stopWatchTimer.onStopTimer();
      return;
    }

    if (currentAttendance.isCheckIn && !currentAttendance.isCheckOut) {
      DateTime end = DateTime.now();

      stopWatchTimer.setPresetTime(
        mSec: end.difference(currentAttendance.waktuCheckIn!).inMilliseconds,
        add: false,
      );

      stopWatchTimer.onStartTimer();
    }
  }
}
