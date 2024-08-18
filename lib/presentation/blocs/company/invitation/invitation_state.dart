part of 'invitation_cubit.dart';

@freezed
class InvitationState with _$InvitationState {
  const factory InvitationState({
    @Default(false) bool isEmailValid,
    @Default(PageStatus.idle) PageStatus status,
    String? message,
  }) = _InvitationState;
}
