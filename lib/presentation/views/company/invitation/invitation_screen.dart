import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/company/invitation/invitation_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: HoraAppBar(
        context,
        actions: const [_SendInvitationIconButton()],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _EmailLabel(),
            _EmailField(),
          ],
        ),
      ),
    );

    return BlocListener<InvitationCubit, InvitationState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.message != current.message,
      listener: (context, state) {
        switch (state.status) {
          case PageStatus.idle:
            // do nothing
            break;
          case PageStatus.busy:
            showHoraLoadingBottomSheet(
              context,
              onCancel: () {
                final cubit = context.read<InvitationCubit>();
                if (!cubit.isClosed) {
                  cubit.cancelRequest();
                }
              },
            );
            break;
          case PageStatus.canceled:
            // do nothing
            break;
          case PageStatus.succeed:
            Navigator.pop(context);
            if (state.message != null) {
              if (state.message == 'Undangan Terkirim') {
                customSnackbar1(tr('snackbar_invitation_sent'));
                Navigator.pop(context);
              } else {
                customSnackbar1(state.message!);
              }
            }
            break;
          case PageStatus.failed:
            Navigator.pop(context);
            customSnackbar1(tr('snackbar_email_not_registered'));
            break;
        }
      },
      child: scaffold,
    );
  }
}

class _EmailLabel extends StatelessWidget {
  const _EmailLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      tr('invitation_title'),
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<InvitationCubit>().emailTextController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr('login_validation_email');
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.send,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: tr('invitation_hint_email'),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorBluePrimary2, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorBluePrimary2, width: 1.5),
        ),
      ),
      onEditingComplete: () =>
          context.read<InvitationCubit>().requestEmailOTP(),
    );
  }
}

class _SendInvitationIconButton extends StatelessWidget {
  const _SendInvitationIconButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      buildWhen: (previous, current) =>
          previous.isEmailValid != current.isEmailValid ||
          previous.status != current.status,
      builder: (context, state) {
        return IconButton(
          onPressed: !state.isEmailValid || state.status.isBusy
              ? null
              : () => _handleSendRequestEmailOTP(context),
          icon: const Icon(Boxicons.bx_send),
        );
      },
    );
  }

  _handleSendRequestEmailOTP(BuildContext context) {
    context.read<InvitationCubit>().requestEmailOTP();
  }
}
