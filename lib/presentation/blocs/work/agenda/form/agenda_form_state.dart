part of 'agenda_form_cubit.dart';

@freezed
class AgendaFormState with _$AgendaFormState {
  const factory AgendaFormState({
    @Default(AutovalidateMode.disabled) AutovalidateMode autoValidateMode,
    String? error,
    StateSubmit? submit,
  }) = _AgendaFormState;
}
