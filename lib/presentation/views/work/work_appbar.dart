import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
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

    return IconButton(
      onPressed: () {},
      icon: const Icon(Boxicons.bx_cog),
    );
  }
}
