import 'package:app/data/models/absence.dart';
import 'package:app/data/models/report/report.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/views/offfice/report/report_handler.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'present/present_form_view.dart';

class OfficeFAB extends StatelessWidget {
  const OfficeFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return BlocBuilder<OfficeCubit, OfficeState>(
          buildWhen: (previous, current) =>
              previous.attendance != current.attendance ||
              previous.leave != current.leave ||
              previous.permit != current.permit ||
              previous.sick != current.sick,
          builder: (context, state) {
            if (state.isAnyCurrentDataSubmitted && controller.index > 0) {
              return const AddFAB();
            }

            switch (controller.index) {
              case 0:
                return const PresenceFAB();
              case 1:
                return const AddFAB(type: ReportType.leave);
              case 2:
                return const AddFAB(type: ReportType.permit);
              case 3:
              default:
                return const AddFAB(type: ReportType.sick);
            }
          },
        );
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
          child: BlocBuilder<OfficeCubit, OfficeState>(
            buildWhen: (previous, current) =>
                previous.selectedDate != current.selectedDate ||
                previous.attendance != current.attendance ||
                previous.isAnyCurrentReportSubmitted !=
                    current.isAnyCurrentReportSubmitted,
            builder: (context, state) {
              final currentAttendance = state.attendance.currentAttendance;
              final isAnyCurrentReportSubmitted =
                  state.isAnyCurrentReportSubmitted;
              final now = DateTime.now();
              final today = DateTime(now.year, now.month, now.day);
              final isCurrent = today == state.selectedDate;

              bool buttonEnabled = false;

              if (isCurrent &&
                  !isAnyCurrentReportSubmitted &&
                  (currentAttendance == null ||
                      !currentAttendance.isCheckOut)) {
                buttonEnabled = true;
              }

              Widget child = HoraButton(
                onPressed: buttonEnabled
                    ? () {
                        PresentFormView.show(context, currentAttendance)
                            .then((saved) {
                          if (saved == true) {
                            context.read<OfficeCubit>().reloadAttendance();
                          }
                        });
                      }
                    : null,
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

              if (!buttonEnabled && isCurrent) {
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
          previous.selectedDate != current.selectedDate ||
          previous.attendance != current.attendance,
      listener: (context, state) {
        _handleTodayAttendanceTimer(
          state.selectedDate,
          state.attendance.currentAttendance,
        );
      },
      child: child,
    );
  }

  _handleTodayAttendanceTimer(
    DateTime selectedDate,
    Absence? currentAttendance,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isCurrent = today == selectedDate;

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

      if (!isCurrent) {
        final start = currentAttendance.waktuCheckIn ?? end;
        end = DateTime(start.year, start.month, start.day, 23, 59, 59);
      }

      stopWatchTimer.setPresetTime(
        mSec: end.difference(currentAttendance.waktuCheckIn!).inMilliseconds,
        add: false,
      );

      if (isCurrent) {
        stopWatchTimer.onStartTimer();
      } else {
        stopWatchTimer.onStopTimer();
      }
    }
  }
}

class AddFAB extends StatelessWidget {
  const AddFAB({super.key, this.type});

  final ReportType? type;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: type == null ? null : () => _handleAddReport(context, type!),
      backgroundColor:
          type == null ? Colors.black.withOpacity(0.62) : colorBluePrimary2,
      foregroundColor: Colors.white,
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }

  _handleAddReport(BuildContext context, ReportType type) {
    final cubit = context.read<OfficeCubit>();

    late final String title, message;

    switch (type) {
      case ReportType.leave:
        title = tr('leave');
        message = tr('leave_submission_confirmation');
        break;
      case ReportType.permit:
        title = tr('permit');
        message = tr('permit_submission_confirmation');
        break;
      case ReportType.sick:
        title = tr('sick');
        message = tr('sick_submission_confirmation');
        break;
    }

    showHoraConfirmationBottomSheet(
      context,
      title: title,
      message: message,
      button: HoraButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: Text(tr('report_submission_button')),
      ),
    ).then((confirm) {
      if (confirm == true) {
        return handleAddReport(context, type);
      }

      return Future.value(confirm);
    }).then((response) {
      if (response == true && !cubit.isClosed) {
        switch (type) {
          case ReportType.leave:
            cubit.getCurrentLeaveList();
            break;
          case ReportType.permit:
            cubit.getCurrentPermitList();
            break;
          case ReportType.sick:
            cubit.getCurrentSickList();
            break;
        }
      }
    }, onError: (e) {
      if (e is PlatformException) {
        customSnackbar1(e.message ?? e.code);
      } else {
        customSnackbar1(tr('snackbar_photo_required'));
      }
    });
  }
}
