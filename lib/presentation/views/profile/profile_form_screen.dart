import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'form_profile.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HoraAppBar(
        context,
        title: Text(tr('edit')),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Boxicons.bxs_save),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.currentUser != current.currentUser,
        builder: (context, state) {
          final user = state.currentUser;
          if (user == null) return const SizedBox.shrink();
          return formProfile(context, user);
        },
      ),
    );
  }
}
