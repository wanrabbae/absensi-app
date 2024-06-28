// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfficeStateImpl _$$OfficeStateImplFromJson(Map<String, dynamic> json) =>
    _$OfficeStateImpl(
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
      attendance: json['attendance'] == null
          ? const OfficeAttendance()
          : OfficeAttendance.fromJson(
              json['attendance'] as Map<String, dynamic>),
      leave: json['leave'] == null
          ? const OfficeLeave()
          : OfficeLeave.fromJson(json['leave'] as Map<String, dynamic>),
      permit: json['permit'] == null
          ? const OfficePermit()
          : OfficePermit.fromJson(json['permit'] as Map<String, dynamic>),
      sick: json['sick'] == null
          ? const OfficeSick()
          : OfficeSick.fromJson(json['sick'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OfficeStateImplToJson(_$OfficeStateImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('selectedDate', instance.selectedDate?.toIso8601String());
  val['attendance'] = instance.attendance.toJson();
  val['leave'] = instance.leave.toJson();
  val['permit'] = instance.permit.toJson();
  val['sick'] = instance.sick.toJson();
  return val;
}

_$OfficeAttendanceImpl _$$OfficeAttendanceImplFromJson(
        Map<String, dynamic> json) =>
    _$OfficeAttendanceImpl(
      currentAttendance: json['currentAttendance'] == null
          ? null
          : Absence.fromJson(json['currentAttendance'] as Map<String, dynamic>),
      listAttendance: (json['listAttendance'] as List<dynamic>?)
          ?.map((e) => Absence.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$OfficeAttendanceImplToJson(
    _$OfficeAttendanceImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentAttendance', instance.currentAttendance?.toJson());
  writeNotNull('listAttendance',
      instance.listAttendance?.map((e) => e.toJson()).toList());
  writeNotNull('error', instance.error);
  return val;
}

_$OfficeLeaveImpl _$$OfficeLeaveImplFromJson(Map<String, dynamic> json) =>
    _$OfficeLeaveImpl(
      listLeave: (json['listLeave'] as List<dynamic>?)
          ?.map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$OfficeLeaveImplToJson(_$OfficeLeaveImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'listLeave', instance.listLeave?.map((e) => e.toJson()).toList());
  writeNotNull('error', instance.error);
  return val;
}

_$OfficePermitImpl _$$OfficePermitImplFromJson(Map<String, dynamic> json) =>
    _$OfficePermitImpl(
      listPermit: (json['listPermit'] as List<dynamic>?)
          ?.map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$OfficePermitImplToJson(_$OfficePermitImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'listPermit', instance.listPermit?.map((e) => e.toJson()).toList());
  writeNotNull('error', instance.error);
  return val;
}

_$OfficeSickImpl _$$OfficeSickImplFromJson(Map<String, dynamic> json) =>
    _$OfficeSickImpl(
      listSick: (json['listSick'] as List<dynamic>?)
          ?.map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$OfficeSickImplToJson(_$OfficeSickImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('listSick', instance.listSick?.map((e) => e.toJson()).toList());
  writeNotNull('error', instance.error);
  return val;
}
