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
