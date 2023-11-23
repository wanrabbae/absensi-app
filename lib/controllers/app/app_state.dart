part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    Profile? currentUser,
    @Default(Company()) Company company,
    @Default([]) List<LiveTracking> liveTrackingList,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Absence? todayAttendance,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}

extension AppStateDate on AppState {
  LiveTracking? liveTracking(String broadcasterId) {
    return liveTrackingList
        .firstWhereOrNull((e) => e.broadcasterId == broadcasterId);
  }
}
