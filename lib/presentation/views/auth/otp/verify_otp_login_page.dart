import 'package:app/components/component_custom.dart';
import 'package:app/core/enums.dart';
import 'package:app/core/themes.dart';
import 'package:app/helpers/base.dart';
import 'package:app/presentation/blocs/auth/login/login_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';

class VerifyOTPLoginPage extends StatelessWidget {
  const VerifyOTPLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: HoraAppBar(
        context,
        actions: const [_VerifyLoginIconButton()],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _OtpLabel(),
            _OtpField(),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
    );

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.otpStatus != current.otpStatus ||
          previous.message != current.message,
      listener: (context, state) {
        switch (state.otpStatus) {
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
            Get.offAllNamed(RouteName.home, arguments: 0);
            break;
          case PageStatus.failed:
            Navigator.pop(context);
            customSnackbar1(tr('snackbar_otp_invalid'));
            break;
        }
      },
      child: scaffold,
    );
  }
}

class _OtpLabel extends StatelessWidget {
  const _OtpLabel();

  @override
  Widget build(BuildContext context) {
    return Text(
      tr('otp_code'),
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().otpTextController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return tr('input_otp_code_help');
        }
        return null;
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.send,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: tr('input_otp_code'),
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
      onEditingComplete: () => context.read<LoginCubit>().verifyEmailOTP(),
      maxLength: 6,
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        required maxLength,
      }) =>
          const SizedBox.shrink(),
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
            tr('resend_otp_question'),
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return HoraButton(
                onPressed: state.status.isBusy
                    ? null
                    : () => context.read<LoginCubit>().requestEmailOTP(),
                child: Text(tr('resend_otp')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerifyLoginIconButton extends StatelessWidget {
  const _VerifyLoginIconButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.isOtpValid != current.isOtpValid ||
          previous.otpStatus != current.otpStatus,
      builder: (context, state) {
        return IconButton(
          onPressed: !state.isOtpValid || state.otpStatus.isBusy
              ? null
              : () => context.read<LoginCubit>().verifyEmailOTP(),
          icon: const Icon(Boxicons.bx_send),
        );
      },
    );
  }
}
