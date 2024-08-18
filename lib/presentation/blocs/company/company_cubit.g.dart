// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyStateImpl _$$CompanyStateImplFromJson(Map<String, dynamic> json) =>
    _$CompanyStateImpl(
      company: json['company'] == null
          ? const Company()
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CompanyStateImplToJson(_$CompanyStateImpl instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
    };
