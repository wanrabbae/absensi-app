import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class OfficeAppBar extends AppBar {
  OfficeAppBar(
    BuildContext context, {
    super.key,
    super.bottom,
    super.elevation,
  }) : super(
          leading: const _OfficeAppBarLeading(),
          centerTitle: true,
          title: Image.asset('assets/icons/logo/hora.png', height: 24),
          actions: [
            const _OfficeAppBarCompany(),
            const SizedBox(width: 8),
          ],
          surfaceTintColor: Colors.white,
          forceMaterialTransparency: true,
        );
}

class _OfficeAppBarCompany extends StatelessWidget {
  const _OfficeAppBarCompany();

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

class _OfficeAppBarLeading extends StatelessWidget {
  const _OfficeAppBarLeading();

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        final selectedDate = state.selectedDate;

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return IconButton(
              tooltip: kDateFullFormat.format(selectedDate),
              onPressed: () => _handleSettings(
                context,
                selectedDate,
                controller.index,
              ),
              icon: const Icon(Boxicons.bx_cog),
            );
          },
        );
      },
    );
  }

  _handleSettings(BuildContext context, DateTime selectedDate, int index) {
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
      if (index == 0)
        ListTile(
          leading: const Icon(Boxicons.bx_show, color: colorGreenPrimary2),
          minLeadingWidth: 0,
          visualDensity: VisualDensity.compact,
          title: Text(
            tr('tile_title_show_active_only'),
            style: const TextStyle(
              color: colorGreenPrimary2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context, 'show_active_only');
          },
        ),
    ];

    showHoraCustomListBottomSheet(context, children: children).then((value) {
      if (value == 'change_date') {
        _changeDate(context, selectedDate);
      } else if (value == 'show_active_only') {
        _showActiveOnly(context);
      }
    });
  }

  void _changeDate(BuildContext context, DateTime selectedDate) {
    final cubit = context.read<OfficeCubit>();
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

  void _showActiveOnly(BuildContext context) {
    final cubit = context.read<OfficeCubit>();
    final now = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    cubit.selectDate(now);
  }
}
