// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_fm.dart';

// **************************************************************************
// FieldValueGenerator
// **************************************************************************

/// Field value key
enum UserFmKey {
  email,
  location,
  isLive,
}

extension UserFmKeyExtension on UserFmKey {
  String get value {
    switch (this) {
      case UserFmKey.email:
        return 'email';
      case UserFmKey.location:
        return 'location';
      case UserFmKey.isLive:
        return 'isLive';
      default:
        throw Exception('Invalid data key.');
    }
  }
}

/// For save data
Map<String, dynamic> _$toData(UserFm doc) {
  final data = <String, dynamic>{};
  Helper.writeNotNull(data, 'email', doc.email);
  Helper.writeNotNull(data, 'location', doc.location);
  Helper.writeNotNull(data, 'isLive', doc.isLive);

  return data;
}

/// For load data
void _$fromData(UserFm doc, Map<String, dynamic> data) {
  doc.email = Helper.valueFromKey<String?>(data, 'email', defaultValue: null);
  doc.location =
      Helper.valueFromKey<GeoPoint?>(data, 'location', defaultValue: null);
  doc.isLive = Helper.valueFromKey<bool?>(data, 'isLive', defaultValue: null);
}
