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
      staff: (json['staff'] as List<dynamic>?)
              ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CompanyStateImplToJson(_$CompanyStateImpl instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
      'staff': instance.staff.map((e) => e.toJson()).toList(),
    };
