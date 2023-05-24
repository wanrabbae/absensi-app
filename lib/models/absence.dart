// To parse this JSON data, do
//
//     final absence = absenceFromMap(jsonString);
import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
class Absence with _$Absence {
  const factory Absence({
    String? name,
    int? id,
    int? companyId,
    String? companyName,
    double? locationLat,
    double? locationLng,
    String? locationName,
    String? checkInTime,
    String? checkOutTime,
    String? lastAbsenceRemark,
    String? photo,
  }) = _Absence;

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);
}
