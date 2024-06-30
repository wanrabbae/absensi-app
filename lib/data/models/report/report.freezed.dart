// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
mixin _$Report {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'idkaryawan')
  String get idKaryawan => throw _privateConstructorUsedError;
  String get namaKaryawan => throw _privateConstructorUsedError;
  String get namaPerusahaan => throw _privateConstructorUsedError;
  dynamic get durasiKerja => throw _privateConstructorUsedError;
  DateTime get tanggalStart => throw _privateConstructorUsedError;
  DateTime get tanggalAkhir => throw _privateConstructorUsedError;
  DateTime get tanggalCuti => throw _privateConstructorUsedError;
  String? get keterangan => throw _privateConstructorUsedError;
  String get dokumen => throw _privateConstructorUsedError;
  @JsonKey(name: 'ijin')
  ReportType get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get iconIjin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res, Report>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'idkaryawan') String idKaryawan,
      String namaKaryawan,
      String namaPerusahaan,
      dynamic durasiKerja,
      DateTime tanggalStart,
      DateTime tanggalAkhir,
      DateTime tanggalCuti,
      String? keterangan,
      String dokumen,
      @JsonKey(name: 'ijin') ReportType type,
      String status,
      String? iconIjin});
}

/// @nodoc
class _$ReportCopyWithImpl<$Res, $Val extends Report>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idKaryawan = null,
    Object? namaKaryawan = null,
    Object? namaPerusahaan = null,
    Object? durasiKerja = freezed,
    Object? tanggalStart = null,
    Object? tanggalAkhir = null,
    Object? tanggalCuti = null,
    Object? keterangan = freezed,
    Object? dokumen = null,
    Object? type = null,
    Object? status = null,
    Object? iconIjin = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      idKaryawan: null == idKaryawan
          ? _value.idKaryawan
          : idKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      durasiKerja: freezed == durasiKerja
          ? _value.durasiKerja
          : durasiKerja // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tanggalStart: null == tanggalStart
          ? _value.tanggalStart
          : tanggalStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tanggalAkhir: null == tanggalAkhir
          ? _value.tanggalAkhir
          : tanggalAkhir // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tanggalCuti: null == tanggalCuti
          ? _value.tanggalCuti
          : tanggalCuti // ignore: cast_nullable_to_non_nullable
              as DateTime,
      keterangan: freezed == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumen: null == dokumen
          ? _value.dokumen
          : dokumen // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      iconIjin: freezed == iconIjin
          ? _value.iconIjin
          : iconIjin // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportImplCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$$ReportImplCopyWith(
          _$ReportImpl value, $Res Function(_$ReportImpl) then) =
      __$$ReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'idkaryawan') String idKaryawan,
      String namaKaryawan,
      String namaPerusahaan,
      dynamic durasiKerja,
      DateTime tanggalStart,
      DateTime tanggalAkhir,
      DateTime tanggalCuti,
      String? keterangan,
      String dokumen,
      @JsonKey(name: 'ijin') ReportType type,
      String status,
      String? iconIjin});
}

/// @nodoc
class __$$ReportImplCopyWithImpl<$Res>
    extends _$ReportCopyWithImpl<$Res, _$ReportImpl>
    implements _$$ReportImplCopyWith<$Res> {
  __$$ReportImplCopyWithImpl(
      _$ReportImpl _value, $Res Function(_$ReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idKaryawan = null,
    Object? namaKaryawan = null,
    Object? namaPerusahaan = null,
    Object? durasiKerja = freezed,
    Object? tanggalStart = null,
    Object? tanggalAkhir = null,
    Object? tanggalCuti = null,
    Object? keterangan = freezed,
    Object? dokumen = null,
    Object? type = null,
    Object? status = null,
    Object? iconIjin = freezed,
  }) {
    return _then(_$ReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      idKaryawan: null == idKaryawan
          ? _value.idKaryawan
          : idKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      namaKaryawan: null == namaKaryawan
          ? _value.namaKaryawan
          : namaKaryawan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      durasiKerja: freezed == durasiKerja
          ? _value.durasiKerja
          : durasiKerja // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tanggalStart: null == tanggalStart
          ? _value.tanggalStart
          : tanggalStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tanggalAkhir: null == tanggalAkhir
          ? _value.tanggalAkhir
          : tanggalAkhir // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tanggalCuti: null == tanggalCuti
          ? _value.tanggalCuti
          : tanggalCuti // ignore: cast_nullable_to_non_nullable
              as DateTime,
      keterangan: freezed == keterangan
          ? _value.keterangan
          : keterangan // ignore: cast_nullable_to_non_nullable
              as String?,
      dokumen: null == dokumen
          ? _value.dokumen
          : dokumen // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      iconIjin: freezed == iconIjin
          ? _value.iconIjin
          : iconIjin // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportImpl implements _Report {
  const _$ReportImpl(
      {required this.id,
      @JsonKey(name: 'idkaryawan') required this.idKaryawan,
      required this.namaKaryawan,
      required this.namaPerusahaan,
      this.durasiKerja,
      required this.tanggalStart,
      required this.tanggalAkhir,
      required this.tanggalCuti,
      this.keterangan,
      required this.dokumen,
      @JsonKey(name: 'ijin') required this.type,
      required this.status,
      this.iconIjin});

  factory _$ReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'idkaryawan')
  final String idKaryawan;
  @override
  final String namaKaryawan;
  @override
  final String namaPerusahaan;
  @override
  final dynamic durasiKerja;
  @override
  final DateTime tanggalStart;
  @override
  final DateTime tanggalAkhir;
  @override
  final DateTime tanggalCuti;
  @override
  final String? keterangan;
  @override
  final String dokumen;
  @override
  @JsonKey(name: 'ijin')
  final ReportType type;
  @override
  final String status;
  @override
  final String? iconIjin;

  @override
  String toString() {
    return 'Report(id: $id, idKaryawan: $idKaryawan, namaKaryawan: $namaKaryawan, namaPerusahaan: $namaPerusahaan, durasiKerja: $durasiKerja, tanggalStart: $tanggalStart, tanggalAkhir: $tanggalAkhir, tanggalCuti: $tanggalCuti, keterangan: $keterangan, dokumen: $dokumen, type: $type, status: $status, iconIjin: $iconIjin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.idKaryawan, idKaryawan) ||
                other.idKaryawan == idKaryawan) &&
            (identical(other.namaKaryawan, namaKaryawan) ||
                other.namaKaryawan == namaKaryawan) &&
            (identical(other.namaPerusahaan, namaPerusahaan) ||
                other.namaPerusahaan == namaPerusahaan) &&
            const DeepCollectionEquality()
                .equals(other.durasiKerja, durasiKerja) &&
            (identical(other.tanggalStart, tanggalStart) ||
                other.tanggalStart == tanggalStart) &&
            (identical(other.tanggalAkhir, tanggalAkhir) ||
                other.tanggalAkhir == tanggalAkhir) &&
            (identical(other.tanggalCuti, tanggalCuti) ||
                other.tanggalCuti == tanggalCuti) &&
            (identical(other.keterangan, keterangan) ||
                other.keterangan == keterangan) &&
            (identical(other.dokumen, dokumen) || other.dokumen == dokumen) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.iconIjin, iconIjin) ||
                other.iconIjin == iconIjin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      idKaryawan,
      namaKaryawan,
      namaPerusahaan,
      const DeepCollectionEquality().hash(durasiKerja),
      tanggalStart,
      tanggalAkhir,
      tanggalCuti,
      keterangan,
      dokumen,
      type,
      status,
      iconIjin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      __$$ReportImplCopyWithImpl<_$ReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportImplToJson(
      this,
    );
  }
}

abstract class _Report implements Report {
  const factory _Report(
      {required final int id,
      @JsonKey(name: 'idkaryawan') required final String idKaryawan,
      required final String namaKaryawan,
      required final String namaPerusahaan,
      final dynamic durasiKerja,
      required final DateTime tanggalStart,
      required final DateTime tanggalAkhir,
      required final DateTime tanggalCuti,
      final String? keterangan,
      required final String dokumen,
      @JsonKey(name: 'ijin') required final ReportType type,
      required final String status,
      final String? iconIjin}) = _$ReportImpl;

  factory _Report.fromJson(Map<String, dynamic> json) = _$ReportImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'idkaryawan')
  String get idKaryawan;
  @override
  String get namaKaryawan;
  @override
  String get namaPerusahaan;
  @override
  dynamic get durasiKerja;
  @override
  DateTime get tanggalStart;
  @override
  DateTime get tanggalAkhir;
  @override
  DateTime get tanggalCuti;
  @override
  String? get keterangan;
  @override
  String get dokumen;
  @override
  @JsonKey(name: 'ijin')
  ReportType get type;
  @override
  String get status;
  @override
  String? get iconIjin;
  @override
  @JsonKey(ignore: true)
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
