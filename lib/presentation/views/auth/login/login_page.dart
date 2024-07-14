import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/auth/login/login_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: HoraAppBar(
        context,
        actions: const [_SendLoginIconButton()],
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
      bottomNavigationBar: const _BottomNavigationBar(),
    );

    return BlocListener<LoginCubit, LoginState>(
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
                final cubit = context.read<LoginCubit>();
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
            if (state.message == 'OTP Terkirim') {
              customSnackbar1(tr('snackbar_otp_sent'));
              final cubit = context.read<LoginCubit>();
              Get.toNamed(RouteName.otpLogin, arguments: cubit);
            } else {
              customSnackbar1(tr('snackbar_check_inbox'));
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
      tr('login_title'),
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
      controller: context.read<LoginCubit>().emailTextController,
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
        hintText: tr('login_hint_email'),
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
      onEditingComplete: () => context.read<LoginCubit>().requestEmailOTP(),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tr('login_footer_caption'),
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return HoraButton(
                onPressed: state.status.isBusy ? null : () {},
                child: Text(tr('login_footer_button')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SendLoginIconButton extends StatelessWidget {
  const _SendLoginIconButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
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
    context.read<LoginCubit>().requestEmailOTP();
  }
}
