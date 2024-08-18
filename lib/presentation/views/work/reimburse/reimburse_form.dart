import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/presentation/blocs/work/klaim/form/klaim_form_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/views/work/work_handlers.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:app/views/home/components/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class _ReimburseFormState {
  bool showBusy = false;
  bool showFailed = false;
  bool showSucceed = false;

  bool get isAnyModalShow => showBusy || showFailed || showSucceed;

  void reset() {
    showBusy = false;
    showFailed = false;
    showSucceed = false;
  }
}

final _state = _ReimburseFormState();

class ReimburseForm extends StatelessWidget {
  ReimburseForm({super.key}) {
    _state.reset();
  }

  @override
  Widget build(BuildContext context) {
    final child = Scaffold(
      appBar: HoraAppBar(
        context,
        titleSpacing: 0,
        title: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser,
          builder: (context, state) {
            final user = state.currentUser;
            if (user == null) {
              return Text(tr('menu_work_reimburse'));
            }

            final photo = user.photo;
            final name = user.name;
            final ImageProvider image = NetworkImage(changeUrlImage(photo));

            return Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  foregroundImage: image,
                ),
                const SizedBox(width: 16),
                Text(name),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              final app = context.read<AppCubit>();
              final state = app.state;
              final profile = state.currentUser!;
              context.read<KlaimFormCubit>().submit(profile);
            },
            icon: const Icon(Boxicons.bx_send),
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: Colors.black,
      extendBody: true,
      body: BlocBuilder<KlaimFormCubit, KlaimFormState>(
        buildWhen: (previous, current) => previous.file != current.file,
        builder: (context, state) {
          return InteractiveViewer(
            child: Center(child: Image.file(File(state.file.path))),
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
              child: BlocBuilder<KlaimFormCubit, KlaimFormState>(
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

    return BlocListener<KlaimFormCubit, KlaimFormState>(
      listenWhen: (previous, current) => previous.submit != current.submit,
      listener: (context, state) {
        final submit = state.submit;

        if (submit == null) return;

        if (_state.isAnyModalShow) {
          Navigator.pop(context);
        }

        switch (submit) {
          case ReimburseStateSubmit.busy:
            _state.showBusy = true;
            showHoraLoadingBottomSheet(
              context,
              onCancel: () {
                context.read<KlaimFormCubit>().cancelSubmit();
              },
            ).then((_) {
              _state.showBusy = false;
            });
            break;
          case ReimburseStateSubmit.failed:
            _state.showFailed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_failed'),
            ).then((_) {
              _state.showFailed = false;
            });
            break;
          case ReimburseStateSubmit.succeed:
            _state.showSucceed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('report_bottom_sheet_info_title'),
              message: tr('report_bottom_sheet_info_message_succeed'),
            ).then((_) {
              _state.showSucceed = false;
              Navigator.pop(context, true);
            });
            break;
          case ReimburseStateSubmit.canceled:
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

      final cubit = context.read<KlaimFormCubit>();
      cubit.setFile(image);
    });
  }

  _handleInputDescription(BuildContext context) {
    final cubit = context.read<KlaimFormCubit>();
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
