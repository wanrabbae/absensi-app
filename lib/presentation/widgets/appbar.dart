import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoraAppBar extends AppBar {
  HoraAppBar(BuildContext context, {super.key, super.bottom, super.elevation})
      : super(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(FeatherIcons.settings),
          ),
          centerTitle: true,
          title: Image.asset('assets/icons/logo/hora.png', height: 24),
          actions: [
            IconButton(
              onPressed: () {},
              icon: BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) =>
                    previous.currentUser != current.currentUser,
                builder: (context, state) {
                  final user = state.currentUser!;

                  return buildImageSizeIcon(
                    context,
                    user.photo != null
                        ? changeUrlImage(user.photo!)
                        : 'assets/icons/logo/hora.png',
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        );
}
