// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
mixin _$Company {
  @JsonKey(name: 'idperusahaan')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'namaPerusahaan')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'logoPerusahaan')
  String get logo => throw _privateConstructorUsedError;
  @JsonKey(name: 'alamatLoc')
  String get alamat => throw _privateConstructorUsedError;
  @JsonKey(name: 'alamatLongtitude')
  String get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'alamatLatitude')
  String get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalLike')
  int get like => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res, Company>;
  @useResult
  $Res call(
      {@JsonKey(name: 'idperusahaan') String id,
      @JsonKey(name: 'namaPerusahaan') String name,
      @JsonKey(name: 'logoPerusahaan') String logo,
      @JsonKey(name: 'alamatLoc') String alamat,
      @JsonKey(name: 'alamatLongtitude') String longitude,
      @JsonKey(name: 'alamatLatitude') String latitude,
      @JsonKey(name: 'totalLike') int like});
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res, $Val extends Company>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logo = null,
    Object? alamat = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? like = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      alamat: null == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyImplCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$$CompanyImplCopyWith(
          _$CompanyImpl value, $Res Function(_$CompanyImpl) then) =
      __$$CompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'idperusahaan') String id,
      @JsonKey(name: 'namaPerusahaan') String name,
      @JsonKey(name: 'logoPerusahaan') String logo,
      @JsonKey(name: 'alamatLoc') String alamat,
      @JsonKey(name: 'alamatLongtitude') String longitude,
      @JsonKey(name: 'alamatLatitude') String latitude,
      @JsonKey(name: 'totalLike') int like});
}

/// @nodoc
class __$$CompanyImplCopyWithImpl<$Res>
    extends _$CompanyCopyWithImpl<$Res, _$CompanyImpl>
    implements _$$CompanyImplCopyWith<$Res> {
  __$$CompanyImplCopyWithImpl(
      _$CompanyImpl _value, $Res Function(_$CompanyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logo = null,
    Object? alamat = null,
    Object? longitude = null,
    Object? latitude = null,
    Object? like = null,
  }) {
    return _then(_$CompanyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      alamat: null == alamat
          ? _value.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyImpl implements _Company {
  const _$CompanyImpl(
      {@JsonKey(name: 'idperusahaan') this.id = 'HORA-001',
      @JsonKey(name: 'namaPerusahaan') this.name = 'PT HORA',
      @JsonKey(name: 'logoPerusahaan')
      this.logo = 'wwwroot/Images/CompanyLogo/logo_hora.png',
      @JsonKey(name: 'alamatLoc')
      this.alamat = 'Jl. Budiluhur No.47 Medan, Indonesia',
      @JsonKey(name: 'alamatLongtitude') this.longitude = '98.6388869',
      @JsonKey(name: 'alamatLatitude') this.latitude = '3.5955809',
      @JsonKey(name: 'totalLike') this.like = 0});

  factory _$CompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyImplFromJson(json);

  @override
  @JsonKey(name: 'idperusahaan')
  final String id;
  @override
  @JsonKey(name: 'namaPerusahaan')
  final String name;
  @override
  @JsonKey(name: 'logoPerusahaan')
  final String logo;
  @override
  @JsonKey(name: 'alamatLoc')
  final String alamat;
  @override
  @JsonKey(name: 'alamatLongtitude')
  final String longitude;
  @override
  @JsonKey(name: 'alamatLatitude')
  final String latitude;
  @override
  @JsonKey(name: 'totalLike')
  final int like;

  @override
  String toString() {
    return 'Company(id: $id, name: $name, logo: $logo, alamat: $alamat, longitude: $longitude, latitude: $latitude, like: $like)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.alamat, alamat) || other.alamat == alamat) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.like, like) || other.like == like));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, logo, alamat, longitude, latitude, like);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      __$$CompanyImplCopyWithImpl<_$CompanyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyImplToJson(
      this,
    );
  }
}

abstract class _Company implements Company {
  const factory _Company(
      {@JsonKey(name: 'idperusahaan') final String id,
      @JsonKey(name: 'namaPerusahaan') final String name,
      @JsonKey(name: 'logoPerusahaan') final String logo,
      @JsonKey(name: 'alamatLoc') final String alamat,
      @JsonKey(name: 'alamatLongtitude') final String longitude,
      @JsonKey(name: 'alamatLatitude') final String latitude,
      @JsonKey(name: 'totalLike') final int like}) = _$CompanyImpl;

  factory _Company.fromJson(Map<String, dynamic> json) = _$CompanyImpl.fromJson;

  @override
  @JsonKey(name: 'idperusahaan')
  String get id;
  @override
  @JsonKey(name: 'namaPerusahaan')
  String get name;
  @override
  @JsonKey(name: 'logoPerusahaan')
  String get logo;
  @override
  @JsonKey(name: 'alamatLoc')
  String get alamat;
  @override
  @JsonKey(name: 'alamatLongtitude')
  String get longitude;
  @override
  @JsonKey(name: 'alamatLatitude')
  String get latitude;
  @override
  @JsonKey(name: 'totalLike')
  int get like;
  @override
  @JsonKey(ignore: true)
  _$$CompanyImplCopyWith<_$CompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
