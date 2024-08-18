import 'package:app/core/enums.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/invitation/invitation.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_cubit.freezed.dart';
part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit(this.api, this.user, this.company) : super(const InvitationState()) {
    emailTextController.addListener(_emailTextControllerListener);
  }

  final ApiService api;
  final Profile user;
  final Company company;
  final emailTextController = TextEditingController();
  CancelToken? _cancelToken;

  void _emailTextControllerListener() {
    final email = emailTextController.text;
    final isEmailValid = EmailValidator.validate(email);
    emit(state.copyWith(isEmailValid: isEmailValid));
  }

  Future<void> requestEmailOTP() async {
    final email = emailTextController.text;
    emit(state.copyWith(status: PageStatus.busy));

    try {
      _cancelToken = CancelToken();
      final request = Invitation(
        receiver: email,
        sender: user.email,
        idPerusahaan: company.id,
        namaPerusahaan: company.name,
      );
      final response = await api.inviteStaff(
        request: request,
        cancelToken: _cancelToken,
      );
      if (isClosed) return;
      String message = response.data;
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

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    emailTextController.removeListener(_emailTextControllerListener);
    return super.close();
  }
}
