part of 'office_cubit.dart';

@freezed
class OfficeState with _$OfficeState {
  const factory OfficeState({
    DateTime? selectedDate,
    @Default(OfficeAttendance()) OfficeAttendance attendance,
    @Default(OfficeLeave()) OfficeLeave leave,
    @Default(OfficePermit()) OfficePermit permit,
    @Default(OfficeSick()) OfficeSick sick,
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
class OfficeLeave with _$OfficeLeave {
  const factory OfficeLeave({
    List<Report>? listLeave,
    String? error,
  }) = _OfficeLeave;

  factory OfficeLeave.fromJson(Map<String, dynamic> json) =>
      _$OfficeLeaveFromJson(json);
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

@freezed
class OfficeSick with _$OfficeSick {
  const factory OfficeSick({
    List<Report>? listSick,
    String? error,
  }) = _OfficeSick;

  factory OfficeSick.fromJson(Map<String, dynamic> json) =>
      _$OfficeSickFromJson(json);
}
