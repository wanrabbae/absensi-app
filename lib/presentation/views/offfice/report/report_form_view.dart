import 'dart:io';

import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/report/report_cubit.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'report_handler.dart';

class _ReportFormState {
  bool showBusy = false;
  bool showFailed = false;
  bool showSucceed = false;

  bool get isAnyModalShow => showBusy || showFailed || showSucceed;
}

class ReportFormView extends StatelessWidget {
  const ReportFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = _ReportFormState();

    final child = Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser,
          builder: (context, state) {
            final user = state.currentUser;
            if (user == null) {
              return BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  return Text(state.type.status);
                },
              );
            }

            final photo = user.photo;
            final name = user.name;
            late final ImageProvider image;
            if (photo != null) {
              image = NetworkImage(changeUrlImage(photo));
            } else {
              image = const AssetImage('assets/icons/logo/hora.png');
            }

            return Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  foregroundImage: image,
                ),
                const SizedBox(width: 16),
                if (name != null) Text(name),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ReportCubit>().submit();
            },
            icon: const Icon(Boxicons.bx_send),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      extendBody: true,
      body: BlocBuilder<ReportCubit, ReportState>(
        buildWhen: (previous, current) => previous.image != current.image,
        builder: (context, state) {
          return InteractiveViewer(
            child: Center(child: Image.file(File(state.image.path))),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            HoraButton(
              onPressed: () => _handleTakePicture(context),
              child: const Icon(Boxicons.bx_camera),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BlocBuilder<ReportCubit, ReportState>(
                buildWhen: (previous, current) =>
                    previous.description != current.description,
                builder: (context, state) {
                  final isSet = state.description.isNotEmpty;

                  if (isSet) {
                    return HoraButton.withIcon(
                      onPressed: () => _handleInputDescription(context),
                      icon: const Icon(Boxicons.bxs_pencil),
                      label: Text(tr('description')),
                    );
                  }

                  return HoraButton.whiteWithIcon(
                    onPressed: () => _handleInputDescription(context),
                    icon: const Icon(Boxicons.bxs_pencil),
                    label: Text(tr('description')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return BlocListener<ReportCubit, ReportState>(
      listenWhen: (previous, current) => previous.submit != current.submit,
      listener: (context, state) {
        final submit = state.submit;

        if (submit == null) return;

        if (form.isAnyModalShow) {
          Navigator.pop(context);
        }

        switch (submit) {
          case ReportStateSubmit.busy:
            form.showBusy = true;
            showHoraLoadingBottomSheet(
              context,
              onCancel: () {
                context.read<ReportCubit>().cancelSubmit();
              },
            ).then((_) {
              form.showBusy = false;
            });
            break;
          case ReportStateSubmit.failed:
            form.showFailed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_failed'),
            ).then((_) {
              form.showFailed = false;
            });
            break;
          case ReportStateSubmit.succeed:
            form.showSucceed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_succeed'),
            ).then((_) {
              form.showSucceed = false;
              Navigator.pop(context, true);
            });
            break;
          case ReportStateSubmit.canceled:
            customSnackbar1(tr('bottom_sheet_loading_canceled_message'));
            break;
        }
      },
      child: child,
    );
  }

  _handleTakePicture(BuildContext context) {
    pickImage().then((XFile? image) {
      if (image == null) {
        return;
      }

      final cubit = context.read<ReportCubit>();
      cubit.setImage(image);
    });
  }

  _handleInputDescription(BuildContext context) {
    final cubit = context.read<ReportCubit>();
    final controller = TextEditingController(text: cubit.state.description);

    showHoraCustomBottomSheet(
      context,
      title: tr('report_bottom_sheet_title'),
      slideUpWithKeyboard: true,
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: tr('report_bottom_sheet_textfield_hint'),
        ),
        textCapitalization: TextCapitalization.sentences,
        minLines: 3,
        maxLines: 3,
      ),
      button: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final isEmpty = controller.text.isEmpty;
          return HoraButton(
            onPressed:
                isEmpty ? null : () => Navigator.pop(context, controller.text),
            child: Text(tr('report_bottom_sheet_button_done')),
          );
        },
      ),
    ).then((result) {
      if (result is String && !cubit.isClosed) {
        cubit.setDescription(result);
      }
    });
  }
}
