// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Agenda _$AgendaFromJson(Map<String, dynamic> json) {
  return _Agenda.fromJson(json);
}

/// @nodoc
mixin _$Agenda {
  DateTime get tanggal => throw _privateConstructorUsedError;
  DateTime get jam => throw _privateConstructorUsedError;
  @JsonKey(name: 'namakaryawan')
  String get namaKaryawan => throw _privateConstructorUsedError;
  String get keterangan => throw _privateConstructorUsedError;
  String? get judul => throw _privateConstructorUsedError;
  @JsonKey(name: 'idkaryawan')
  String get idkaryawan => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgendaCopyWith<Agenda> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaCopyWith<$Res> {
  factory $AgendaCopyWith(Agenda value, $Res Function(Agenda) then) =
      _$AgendaCopyWithImpl<$Res, Agenda>;
  @useResult
  $Res call(
      {DateTime tanggal,
      DateTime jam,
      @JsonKey(name: 'namakaryawan') String namaKaryawan,
      String keterangan,
      String? judul,
      @JsonKey(name: 'idkaryawan') String idkaryawan,
      String status});
}

/// @nodoc
class _$AgendaCopyWithImpl<$Res, $Val extends Agenda>
    implements $AgendaCopyWith<$Res> {
  _$AgendaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tanggal = null,
    Object? jam = null,
    Object? namaKaryawan = null,
    Object? keterangan = null,
    Object? judul = freezed,
    Object? idkaryawan = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      tanggal: null == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jam: null == jam
          ? _value.jam
          : jam // ignore: cast_nullable_to_non_nullable
              as DateTime,
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String,
      judul: freezed == judul
          ? _value.judul
          : judul // ignore: cast_nullable_to_non_nullable
              as String?,
      idkaryawan: null == idkaryawan
          ? _value.idkaryawan
          : idkaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaImplCopyWith<$Res> implements $AgendaCopyWith<$Res> {
  factory _$$AgendaImplCopyWith(
          _$AgendaImpl value, $Res Function(_$AgendaImpl) then) =
      __$$AgendaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime tanggal,
      DateTime jam,
      @JsonKey(name: 'namakaryawan') String namaKaryawan,
      String keterangan,
      String? judul,
      @JsonKey(name: 'idkaryawan') String idkaryawan,
      String status});
}

/// @nodoc
class __$$AgendaImplCopyWithImpl<$Res>
    extends _$AgendaCopyWithImpl<$Res, _$AgendaImpl>
    implements _$$AgendaImplCopyWith<$Res> {
  __$$AgendaImplCopyWithImpl(
      _$AgendaImpl _value, $Res Function(_$AgendaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tanggal = null,
    Object? jam = null,
    Object? namaKaryawan = null,
    Object? keterangan = null,
    Object? judul = freezed,
    Object? idkaryawan = null,
    Object? status = null,
  }) {
    return _then(_$AgendaImpl(
      tanggal: null == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as DateTime,
      jam: null == jam
          ? _value.jam
          : jam // ignore: cast_nullable_to_non_nullable
              as DateTime,
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String,
      judul: freezed == judul
          ? _value.judul
          : judul // ignore: cast_nullable_to_non_nullable
              as String?,
      idkaryawan: null == idkaryawan
          ? _value.idkaryawan
          : idkaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgendaImpl implements _Agenda {
  const _$AgendaImpl(
      {required this.tanggal,
      required this.jam,
      @JsonKey(name: 'namakaryawan') required this.namaKaryawan,
      required this.keterangan,
      this.judul,
      @JsonKey(name: 'idkaryawan') required this.idkaryawan,
      required this.status});

  factory _$AgendaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgendaImplFromJson(json);

  @override
  final DateTime tanggal;
  @override
  final DateTime jam;
  @override
  @JsonKey(name: 'namakaryawan')
  final String namaKaryawan;
  @override
  final String keterangan;
  @override
  final String? judul;
  @override
  @JsonKey(name: 'idkaryawan')
  final String idkaryawan;
  @override
  final String status;

  @override
  String toString() {
    return 'Agenda(tanggal: $tanggal, jam: $jam, namaKaryawan: $namaKaryawan, keterangan: $keterangan, judul: $judul, idkaryawan: $idkaryawan, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaImpl &&
            (identical(other.tanggal, tanggal) || other.tanggal == tanggal) &&
            (identical(other.jam, jam) || other.jam == jam) &&
            (identical(other.namaKaryawan, namaKaryawan) ||
                other.namaKaryawan == namaKaryawan) &&
            (identical(other.keterangan, keterangan) ||
                other.keterangan == keterangan) &&
            (identical(other.judul, judul) || other.judul == judul) &&
            (identical(other.idkaryawan, idkaryawan) ||
                other.idkaryawan == idkaryawan) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tanggal, jam, namaKaryawan,
      keterangan, judul, idkaryawan, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      __$$AgendaImplCopyWithImpl<_$AgendaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgendaImplToJson(
      this,
    );
  }
}

abstract class _Agenda implements Agenda {
  const factory _Agenda(
      {required final DateTime tanggal,
      required final DateTime jam,
      @JsonKey(name: 'namakaryawan') required final String namaKaryawan,
      required final String keterangan,
      final String? judul,
      @JsonKey(name: 'idkaryawan') required final String idkaryawan,
      required final String status}) = _$AgendaImpl;

  factory _Agenda.fromJson(Map<String, dynamic> json) = _$AgendaImpl.fromJson;

  @override
  DateTime get tanggal;
  @override
  DateTime get jam;
  @override
  @JsonKey(name: 'namakaryawan')
  String get namaKaryawan;
  @override
  String get keterangan;
  @override
  String? get judul;
  @override
  @JsonKey(name: 'idkaryawan')
  String get idkaryawan;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AgendaMutable _$AgendaMutableFromJson(Map<String, dynamic> json) {
  return _AgendaMutable.fromJson(json);
}

/// @nodoc
mixin _$AgendaMutable {
  String get namaKaryawan => throw _privateConstructorUsedError;
  String get keterangan => throw _privateConstructorUsedError;
  String get tanggal => throw _privateConstructorUsedError;
  String get namaPerusahaan => throw _privateConstructorUsedError;
  String get idperusahaan => throw _privateConstructorUsedError;
  String get judul => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgendaMutableCopyWith<AgendaMutable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaMutableCopyWith<$Res> {
  factory $AgendaMutableCopyWith(
          AgendaMutable value, $Res Function(AgendaMutable) then) =
      _$AgendaMutableCopyWithImpl<$Res, AgendaMutable>;
  @useResult
  $Res call(
      {String namaKaryawan,
      String keterangan,
      String tanggal,
      String namaPerusahaan,
      String idperusahaan,
      String judul});
}

/// @nodoc
class _$AgendaMutableCopyWithImpl<$Res, $Val extends AgendaMutable>
    implements $AgendaMutableCopyWith<$Res> {
  _$AgendaMutableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namaKaryawan = null,
    Object? keterangan = null,
    Object? tanggal = null,
    Object? namaPerusahaan = null,
    Object? idperusahaan = null,
    Object? judul = null,
  }) {
    return _then(_value.copyWith(
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String,
      tanggal: null == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      idperusahaan: null == idperusahaan
          ? _value.idperusahaan
          : idperusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      judul: null == judul
          ? _value.judul
          : judul // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaMutableImplCopyWith<$Res>
    implements $AgendaMutableCopyWith<$Res> {
  factory _$$AgendaMutableImplCopyWith(
          _$AgendaMutableImpl value, $Res Function(_$AgendaMutableImpl) then) =
      __$$AgendaMutableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String namaKaryawan,
      String keterangan,
      String tanggal,
      String namaPerusahaan,
      String idperusahaan,
      String judul});
}

/// @nodoc
class __$$AgendaMutableImplCopyWithImpl<$Res>
    extends _$AgendaMutableCopyWithImpl<$Res, _$AgendaMutableImpl>
    implements _$$AgendaMutableImplCopyWith<$Res> {
  __$$AgendaMutableImplCopyWithImpl(
      _$AgendaMutableImpl _value, $Res Function(_$AgendaMutableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namaKaryawan = null,
    Object? keterangan = null,
    Object? tanggal = null,
    Object? namaPerusahaan = null,
    Object? idperusahaan = null,
    Object? judul = null,
  }) {
    return _then(_$AgendaMutableImpl(
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      keterangan: null == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String,
      tanggal: null == tanggal
          ? _value.tanggal
          : tanggal // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      idperusahaan: null == idperusahaan
          ? _value.idperusahaan
          : idperusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      judul: null == judul
          ? _value.judul
          : judul // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgendaMutableImpl implements _AgendaMutable {
  const _$AgendaMutableImpl(
      {required this.namaKaryawan,
      required this.keterangan,
      required this.tanggal,
      required this.namaPerusahaan,
      required this.idperusahaan,
      required this.judul});

  factory _$AgendaMutableImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgendaMutableImplFromJson(json);

  @override
  final String namaKaryawan;
  @override
  final String keterangan;
  @override
  final String tanggal;
  @override
  final String namaPerusahaan;
  @override
  final String idperusahaan;
  @override
  final String judul;

  @override
  String toString() {
    return 'AgendaMutable(namaKaryawan: $namaKaryawan, keterangan: $keterangan, tanggal: $tanggal, namaPerusahaan: $namaPerusahaan, idperusahaan: $idperusahaan, judul: $judul)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaMutableImpl &&
            (identical(other.namaKaryawan, namaKaryawan) ||
                other.namaKaryawan == namaKaryawan) &&
            (identical(other.keterangan, keterangan) ||
                other.keterangan == keterangan) &&
            (identical(other.tanggal, tanggal) || other.tanggal == tanggal) &&
            (identical(other.namaPerusahaan, namaPerusahaan) ||
                other.namaPerusahaan == namaPerusahaan) &&
            (identical(other.idperusahaan, idperusahaan) ||
                other.idperusahaan == idperusahaan) &&
            (identical(other.judul, judul) || other.judul == judul));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, namaKaryawan, keterangan,
      tanggal, namaPerusahaan, idperusahaan, judul);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaMutableImplCopyWith<_$AgendaMutableImpl> get copyWith =>
      __$$AgendaMutableImplCopyWithImpl<_$AgendaMutableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgendaMutableImplToJson(
      this,
    );
  }
}

abstract class _AgendaMutable implements AgendaMutable {
  const factory _AgendaMutable(
      {required final String namaKaryawan,
      required final String keterangan,
      required final String tanggal,
      required final String namaPerusahaan,
      required final String idperusahaan,
      required final String judul}) = _$AgendaMutableImpl;

  factory _AgendaMutable.fromJson(Map<String, dynamic> json) =
      _$AgendaMutableImpl.fromJson;

  @override
  String get namaKaryawan;
  @override
  String get keterangan;
  @override
  String get tanggal;
  @override
  String get namaPerusahaan;
  @override
  String get idperusahaan;
  @override
  String get judul;
  @override
  @JsonKey(ignore: true)
  _$$AgendaMutableImplCopyWith<_$AgendaMutableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
