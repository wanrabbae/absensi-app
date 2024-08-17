import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class WorkAppBar extends AppBar {
  WorkAppBar(
    BuildContext context, {
    super.key,
    super.bottom,
    super.elevation,
  }) : super(
          leading: const _WorkAppBarLeading(),
          actions: [
            const _WorkAppBarCompany(),
            const SizedBox(width: 8),
          ],
          surfaceTintColor: Colors.white,
          forceMaterialTransparency: true,
        );
}

class _WorkAppBarCompany extends StatelessWidget {
  const _WorkAppBarCompany();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.toNamed(RouteName.companyScreen);
      },
      icon: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.company != current.company,
        builder: (context, state) {
          final company = state.company;

          return buildImageSizeIcon(
            context,
            company.logo.startsWith('wwwroot/')
                ? changeUrlImage(company.logo)
                : 'assets/icons/logo/hora.png',
          );
        },
      ),
    );
  }
}

class _WorkAppBarLeading extends StatelessWidget {
  const _WorkAppBarLeading();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkCubit, WorkState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        final selectedDate = state.selectedDate;

        return IconButton(
          tooltip: kDateFullFormat.format(selectedDate),
          onPressed: () => _handleSettings(
            context,
            selectedDate,
          ),
          icon: const Icon(Boxicons.bx_cog),
        );
      },
    );
  }

  _handleSettings(BuildContext context, DateTime selectedDate) {
    final children = <ListTile>[
      ListTile(
        leading: const Icon(Boxicons.bx_calendar),
        minLeadingWidth: 0,
        visualDensity: VisualDensity.compact,
        title: Text(
          tr('tile_title_change_date'),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.pop(context, 'change_date');
        },
      ),
    ];

    showHoraCustomListBottomSheet(context, children: children).then((value) {
      if (value == 'change_date') {
        _changeDate(context, selectedDate);
      }
    });
  }

  void _changeDate(BuildContext context, DateTime selectedDate) {
    final cubit = context.read<WorkCubit>();
    final now = DateTime.now();
    showDatePicker(
      locale: context.locale,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010, 1, 1),
      lastDate: now.copyWith(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 999,
        microsecond: 999,
      ),
      currentDate: now,
      initialDatePickerMode: DatePickerMode.day,
    ).then((value) {
      if (value == null || cubit.isClosed) return;
      cubit.selectDate(value);
    });
  }
}
