part of 'klaim_form_cubit.dart';

enum ReimburseStateSubmit { busy, failed, succeed, canceled }

@freezed
class KlaimFormState with _$KlaimFormState {
  const factory KlaimFormState({
    required XFile file,
    @Default('') String description,
    String? error,
    ReimburseStateSubmit? submit,
  }) = _KlaimFormState;
}
