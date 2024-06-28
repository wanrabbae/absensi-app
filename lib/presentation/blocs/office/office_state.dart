part of 'office_cubit.dart';

@freezed
class OfficeState with _$OfficeState {
  const factory OfficeState({
    DateTime? selectedDate,
    @Default(OfficeAttendance()) OfficeAttendance attendance,
  }) = _OfficeState;

  factory OfficeState.fromJson(Map<String, dynamic> json) =>
      _$OfficeStateFromJson(json);
}

@freezed
class OfficeAttendance with _$OfficeAttendance {
  const factory OfficeAttendance({
    Absence? currentAttendance,
    List<Absence>? listAttendance,
    String? error,
  }) = _OfficeAttendance;

  factory OfficeAttendance.fromJson(Map<String, dynamic> json) =>
      _$OfficeAttendanceFromJson(json);
}
