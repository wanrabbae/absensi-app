// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvitationImpl _$$InvitationImplFromJson(Map<String, dynamic> json) =>
    _$InvitationImpl(
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      idPerusahaan: json['idperusahaan'] as String,
      namaPerusahaan: json['namaPerusahaan'] as String,
    );

Map<String, dynamic> _$$InvitationImplToJson(_$InvitationImpl instance) =>
    <String, dynamic>{
      'receiver': instance.receiver,
      'sender': instance.sender,
      'idperusahaan': instance.idPerusahaan,
      'namaPerusahaan': instance.namaPerusahaan,
    };
