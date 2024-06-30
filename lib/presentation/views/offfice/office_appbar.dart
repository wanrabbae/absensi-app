import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/office/office_cubit.dart';
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
    return BlocBuilder<OfficeCubit, OfficeState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate,
      builder: (context, state) {
        final selectedDate = state.selectedDate;

        return IconButton(
          tooltip: kDateFullFormat.format(selectedDate),
          onPressed: () {
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
          },
          icon: const Icon(Boxicons.bx_cog),
        );
      },
    );
  }
}
