part of 'office_cubit.dart';

@freezed
class OfficeState with _$OfficeState {
  const factory OfficeState({
    DateTime? selectedDate,
    @Default(OfficeAttendance()) OfficeAttendance attendance,
    @Default(OfficePermit()) OfficePermit permit,
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

@freezed
class OfficePermit with _$OfficePermit {
  const factory OfficePermit({
    List<Report>? listPermit,
    String? error,
  }) = _OfficePermit;

  factory OfficePermit.fromJson(Map<String, dynamic> json) =>
      _$OfficePermitFromJson(json);
}
