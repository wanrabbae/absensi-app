import 'package:app/components/component_custom.dart';
import 'package:app/core/themes.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/work/agenda/form/agenda_form_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class _AgendaFormState {
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

final _state = _AgendaFormState();

class AgendaForm extends StatelessWidget {
  AgendaForm({super.key}) {
    _state.reset();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AgendaFormCubit>();

    final child = Scaffold(
      appBar: HoraAppBar(
        context,
        title: const HoraAppBarCurrentUserTitle(),
        actions: const [_SubmitIconButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AgendaFormCubit, AgendaFormState>(
          buildWhen: (previous, current) =>
          previous.autoValidateMode != current.autoValidateMode,
          builder: (context, state) {
            return Form(
              key: cubit.formKey,
              autovalidateMode: state.autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    tr('work_agenda_form_title'),
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    controller: cubit.titleController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: colorBottomSheetDrag),
                      ),
                      hintText: tr('work_agenda_form_title_hint'),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    tr('work_agenda_form_description'),
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    controller: cubit.descriptionController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: colorBottomSheetDrag),
                      ),
                      hintText: tr('work_agenda_form_description_hint'),
                    ),
                    minLines: 3,
                    maxLines: 5,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      return null;
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return BlocListener<AgendaFormCubit, AgendaFormState>(
      listenWhen: (previous, current) => previous.submit != current.submit,
      listener: (context, state) {
        final submit = state.submit;

        if (submit == null) return;

        if (_state.isAnyModalShow) {
          Navigator.pop(context);
        }

        switch (submit) {
          case StateSubmit.busy:
            _state.showBusy = true;
            showHoraLoadingBottomSheet(
              context,
              onCancel: () {
                context.read<AgendaFormCubit>().cancelSubmit();
              },
            ).then((_) {
              _state.showBusy = false;
            });
            break;
          case StateSubmit.failed:
            _state.showFailed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('agenda_bottom_sheet_info_title'),
              message: tr('agenda_bottom_sheet_info_message_failed'),
            ).then((_) {
              _state.showFailed = false;
            });
            break;
          case StateSubmit.succeed:
            _state.showSucceed = true;
            showHoraInfoBottomSheet(
              context,
              title: tr('agenda_bottom_sheet_info_title'),
              message: tr('agenda_bottom_sheet_info_message_succeed'),
            ).then((_) {
              _state.showSucceed = false;
              Navigator.pop(context, true);
            });
            break;
          case StateSubmit.canceled:
            customSnackbar1(tr('bottom_sheet_loading_canceled_message'));
            break;
        }
      },
      child: child,
    );
  }
}

class _SubmitIconButton extends StatelessWidget {
  const _SubmitIconButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaFormCubit, AgendaFormState>(
      buildWhen: (previous, current) => previous.submit != current.submit,
      builder: (context, state) {
        final busy = state.submit == StateSubmit.busy;

        return IconButton(
          onPressed: busy ? null : () => _handleSubmit(context),
          icon: const Icon(Boxicons.bx_send),
        );
      },
    );
  }

  _handleSubmit(BuildContext context) {
    final cubit = context.read<AgendaFormCubit>();
    if (!cubit.formKey.currentState!.validate()) {
      if (cubit.state.autoValidateMode == AutovalidateMode.disabled) {
        cubit.setAutoValidateMode(AutovalidateMode.always);
      }
      return;
    }
    cubit.submit();
  }
}
