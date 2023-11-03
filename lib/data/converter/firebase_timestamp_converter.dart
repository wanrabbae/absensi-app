import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FirebaseTimestampConverter extends JsonConverter<DateTime, dynamic> {
  const FirebaseTimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    return DateTime.parse(json.toString());
  }

  @override
  dynamic toJson(DateTime object) {
    return object.toUtc().toIso8601String();
  }
}
