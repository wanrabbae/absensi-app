part of 'live_location_log_cubit.dart';

@freezed
class LiveLocationLogState with _$LiveLocationLogState {
  const factory LiveLocationLogState({
    List<LiveLocationLog>? data,
    String? error,
  }) = _LiveLocationLogState;
}
