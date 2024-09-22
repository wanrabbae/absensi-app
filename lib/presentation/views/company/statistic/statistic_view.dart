import 'package:app/components/component_custom.dart';
import 'package:app/controllers/management/management_cubit.dart';
import 'package:app/core/themes.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/presentation/widgets/empty_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView>
    with AutomaticKeepAliveClientMixin {
  final rxDateRange = ValueNotifier<DateTimeRange?>(null);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
    //   child: SimpleEmptyView(
    //     title: tr('company_tab_statistic_not_found'),
    //     button: HoraButton(
    //       onPressed: () {},
    //       child: Text(tr('company_tab_statistic_not_found_action_button')),
    //     ),
    //   ),
    // );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                final now = DateTime.now();
                final initialDateRange = rxDateRange.value ??
                    DateTimeRange(
                      start: DateTime(now.year, now.month, 1),
                      end: now,
                    );

                showDateRangePicker(
                  context: context,
                  locale: context.locale,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(now.year, now.month, now.day),
                  initialDateRange: initialDateRange,
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        useMaterial3: true,
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: colorBluePrimary,
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    rxDateRange.value = value;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: colorBlueOpacity,
                ),
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: rxDateRange,
                      builder: (context, child) {
                        final range = rxDateRange.value;

                        if (range == null) {
                          return child!;
                        }

                        return Text(
                          '${kDateFullFormat.format(range.start)} - ${kDateFullFormat.format(range.end)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                      child: Text(
                        tr('management_interval'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ManagementCard(
          title: tr('present'),
          description: tr('management_present_description'),
          onShareEmail: () {
            final range = rxDateRange.value;
            if (range != null) {
              customSnackbar1(tr('snackbar_sending_management'));
              context
                  .read<ManagementCubit>()
                  .sendReportAbsensi(range, customSnackbar1);
            } else {
              customSnackbar1(tr('snackbar_validation_management'));
            }
          },
        ),
        ManagementCard(
          title: tr('leave'),
          description: tr('management_leave_description'),
          onShareEmail: () {
            final range = rxDateRange.value;
            if (range != null) {
              customSnackbar1(tr('snackbar_sending_management'));
              context
                  .read<ManagementCubit>()
                  .sendReportCuti(range, customSnackbar1);
            } else {
              customSnackbar1(tr('snackbar_validation_management'));
            }
          },
        ),
        ManagementCard(
          title: tr('permit'),
          description: tr('management_permit_description'),
          onShareEmail: () {
            final range = rxDateRange.value;
            if (range != null) {
              customSnackbar1(tr('snackbar_sending_management'));
              context
                  .read<ManagementCubit>()
                  .sendReportIzin(range, customSnackbar1);
            } else {
              customSnackbar1(tr('snackbar_validation_management'));
            }
          },
        ),
        ManagementCard(
          title: tr('sick'),
          description: tr('management_sick_description'),
          onShareEmail: () {
            final range = rxDateRange.value;
            if (range != null) {
              customSnackbar1(tr('snackbar_sending_management'));
              context
                  .read<ManagementCubit>()
                  .sendReportSakit(range, customSnackbar1);
            } else {
              customSnackbar1(tr('snackbar_validation_management'));
            }
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ManagementCard extends StatelessWidget {
  const ManagementCard({
    super.key,
    required this.title,
    required this.description,
    required this.onShareEmail,
  });

  final String title;
  final String description;
  final VoidCallback onShareEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: colorBlueOpacity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onShareEmail,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: colorBlackPrimary,
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(FeatherIcons.share, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    tr('management_share_to_email'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
