part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    Profile? currentUser,
    Company? company,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
