import 'package:app/data/models/auth/verify_otp.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api, this.box) : super(const LoginState()) {
    emailTextController.addListener(_emailTextControllerListener);
    otpTextController.addListener(_otpTextControllerListener);
  }

  final ApiService api;
  final GetStorage box;
  final emailTextController = TextEditingController();
  final otpTextController = TextEditingController();
  CancelToken? _cancelToken;

  void _emailTextControllerListener() {
    final email = emailTextController.text;
    final isEmailValid = EmailValidator.validate(email);
    emit(state.copyWith(isEmailValid: isEmailValid));
  }

  void _otpTextControllerListener() {
    final otp = otpTextController.text;
    emit(state.copyWith(isOtpValid: otp.length == 6));
  }

  Future<void> requestEmailOTP() async {
    final email = emailTextController.text;
    emit(state.copyWith(status: PageStatus.busy));

    try {
      _cancelToken = CancelToken();
      String message = await api.requestEmailOTP(
        email: email,
        cancelToken: _cancelToken,
      );
      if (isClosed) return;
      message = message.replaceAll(r'"', '');
      emit(state.copyWith(status: PageStatus.succeed, message: message));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        debugPrintStack(stackTrace: s);
      }
      if (isClosed) return;
      if (e is DioError && e.type == DioErrorType.cancel) {
        emit(state.copyWith(status: PageStatus.canceled));
      } else {
        emit(state.copyWith(status: PageStatus.failed));
      }
    } finally {
      _cancelToken = null;
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (isClosed) return;
      emit(state.copyWith(status: PageStatus.idle, message: null));
    });
  }

  void cancelRequest() => _cancelToken?.cancel();

  Future<void> verifyEmailOTP() async {
    final email = emailTextController.text;
    final otp = otpTextController.text;
    emit(state.copyWith(otpStatus: PageStatus.busy));

    try {
      _cancelToken = CancelToken();
      final verified = await api.verifyEmailOTP(
        email: email,
        otp: otp,
        cancelToken: _cancelToken,
      );
      box.write(Base.token, verified.token);
      box.write(Base.email, email);
      if (isClosed) return;
      emit(state.copyWith(otpStatus: PageStatus.succeed, otp: verified));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        debugPrintStack(stackTrace: s);
      }
      if (isClosed) return;
      if (e is DioError && e.type == DioErrorType.cancel) {
        emit(state.copyWith(otpStatus: PageStatus.canceled));
      } else {
        emit(state.copyWith(otpStatus: PageStatus.failed));
      }
    } finally {
      _cancelToken = null;
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (isClosed) return;
      emit(state.copyWith(otpStatus: PageStatus.idle, otp: null));
    });
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    emailTextController.removeListener(_emailTextControllerListener);
    otpTextController.removeListener(_otpTextControllerListener);
    return super.close();
  }
}
