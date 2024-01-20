part of 'klaim_form_cubit.dart';

@freezed
class KlaimFormState with _$KlaimFormState {
  const factory KlaimFormState({
    required XFile file,
    bool? busy,
    String? error,
  }) = _KlaimFormState;
}
