part of 'office_cubit.dart';

@freezed
class OfficeState with _$OfficeState {
  const OfficeState._();

  const factory OfficeState({
    required Profile user,
    required Company company,
    required DateTime selectedDate,
    @Default(OfficeAttendance()) OfficeAttendance attendance,
    @Default(OfficeLeave()) OfficeLeave leave,
    @Default(OfficePermit()) OfficePermit permit,
    @Default(OfficeSick()) OfficeSick sick,
  }) = _OfficeState;

  factory OfficeState.fromJson(Map<String, dynamic> json) =>
      _$OfficeStateFromJson(json);

  bool get isAnyCurrentDataSubmitted {
    final isAttendance = attendance.currentAttendance != null;

    return isAttendance || isAnyCurrentReportSubmitted;
  }

  bool get isAnyCurrentReportSubmitted {
    bool isLeave = true, isPermit = true, isSick = true;
    if (user.idkaryawan != null) {
      isLeave = leave.currentLeave(user.idkaryawan!) != null;
      isPermit = permit.currentPermit(user.idkaryawan!) != null;
      isSick = sick.currentSick(user.idkaryawan!) != null;
    }

    return isLeave || isPermit || isSick;
  }
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
  const OfficeLeave._();

  const factory OfficeLeave({
    List<Report>? listLeave,
    String? error,
  }) = _OfficeLeave;

  factory OfficeLeave.fromJson(Map<String, dynamic> json) =>
      _$OfficeLeaveFromJson(json);

  Report? currentLeave(String idKaryawan) {
    return listLeave
        ?.firstWhereOrNull((leave) => leave.idKaryawan == idKaryawan);
  }
}

@freezed
class OfficePermit with _$OfficePermit {
  const OfficePermit._();

  const factory OfficePermit({
    List<Report>? listPermit,
    String? error,
  }) = _OfficePermit;

  factory OfficePermit.fromJson(Map<String, dynamic> json) =>
      _$OfficePermitFromJson(json);

  Report? currentPermit(String idKaryawan) {
    return listPermit
        ?.firstWhereOrNull((permit) => permit.idKaryawan == idKaryawan);
  }
}

@freezed
class OfficeSick with _$OfficeSick {
  const OfficeSick._();

  const factory OfficeSick({
    List<Report>? listSick,
    String? error,
  }) = _OfficeSick;

  factory OfficeSick.fromJson(Map<String, dynamic> json) =>
      _$OfficeSickFromJson(json);

  Report? currentSick(String idKaryawan) {
    return listSick?.firstWhereOrNull((sick) => sick.idKaryawan == idKaryawan);
  }
}
