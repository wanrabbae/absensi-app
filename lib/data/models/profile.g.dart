// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      isEmailVerify: json['isEmailVerify'] as bool?,
      gender: json['gender'] as String?,
      genderCode: json['genderCode'] as String?,
      photo: json['photo'] as String?,
      joinDate: json['joinDate'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'isEmailVerify': instance.isEmailVerify,
      'gender': instance.gender,
      'genderCode': instance.genderCode,
      'photo': instance.photo,
      'joinDate': instance.joinDate,
    };
