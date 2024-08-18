// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CompanyState _$CompanyStateFromJson(Map<String, dynamic> json) {
  return _CompanyState.fromJson(json);
}

/// @nodoc
mixin _$CompanyState {
  Company get company => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyStateCopyWith<CompanyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyStateCopyWith<$Res> {
  factory $CompanyStateCopyWith(
          CompanyState value, $Res Function(CompanyState) then) =
      _$CompanyStateCopyWithImpl<$Res, CompanyState>;
  @useResult
  $Res call({Company company});

  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class _$CompanyStateCopyWithImpl<$Res, $Val extends CompanyState>
    implements $CompanyStateCopyWith<$Res> {
  _$CompanyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
  }) {
    return _then(_value.copyWith(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res> get company {
    return $CompanyCopyWith<$Res>(_value.company, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyStateImplCopyWith<$Res>
    implements $CompanyStateCopyWith<$Res> {
  factory _$$CompanyStateImplCopyWith(
          _$CompanyStateImpl value, $Res Function(_$CompanyStateImpl) then) =
      __$$CompanyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Company company});

  @override
  $CompanyCopyWith<$Res> get company;
}

/// @nodoc
class __$$CompanyStateImplCopyWithImpl<$Res>
    extends _$CompanyStateCopyWithImpl<$Res, _$CompanyStateImpl>
    implements _$$CompanyStateImplCopyWith<$Res> {
  __$$CompanyStateImplCopyWithImpl(
      _$CompanyStateImpl _value, $Res Function(_$CompanyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? company = null,
  }) {
    return _then(_$CompanyStateImpl(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyStateImpl implements _CompanyState {
  const _$CompanyStateImpl({this.company = const Company()});

  factory _$CompanyStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyStateImplFromJson(json);

  @override
  @JsonKey()
  final Company company;

  @override
  String toString() {
    return 'CompanyState(company: $company)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyStateImpl &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, company);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyStateImplCopyWith<_$CompanyStateImpl> get copyWith =>
      __$$CompanyStateImplCopyWithImpl<_$CompanyStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyStateImplToJson(
      this,
    );
  }
}

abstract class _CompanyState implements CompanyState {
  const factory _CompanyState({final Company company}) = _$CompanyStateImpl;

  factory _CompanyState.fromJson(Map<String, dynamic> json) =
      _$CompanyStateImpl.fromJson;

  @override
  Company get company;
  @override
  @JsonKey(ignore: true)
  _$$CompanyStateImplCopyWith<_$CompanyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
