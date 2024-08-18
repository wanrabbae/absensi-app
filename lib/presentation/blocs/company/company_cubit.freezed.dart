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
  List<Profile> get staff => throw _privateConstructorUsedError;

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
  $Res call({Company company, List<Profile> staff});

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
    Object? staff = null,
  }) {
    return _then(_value.copyWith(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      staff: null == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
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
  $Res call({Company company, List<Profile> staff});

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
    Object? staff = null,
  }) {
    return _then(_$CompanyStateImpl(
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      staff: null == staff
          ? _value._staff
          : staff // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyStateImpl implements _CompanyState {
  const _$CompanyStateImpl(
      {this.company = const Company(), final List<Profile> staff = const []})
      : _staff = staff;

  factory _$CompanyStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyStateImplFromJson(json);

  @override
  @JsonKey()
  final Company company;
  final List<Profile> _staff;
  @override
  @JsonKey()
  List<Profile> get staff {
    if (_staff is EqualUnmodifiableListView) return _staff;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staff);
  }

  @override
  String toString() {
    return 'CompanyState(company: $company, staff: $staff)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyStateImpl &&
            (identical(other.company, company) || other.company == company) &&
            const DeepCollectionEquality().equals(other._staff, _staff));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, company, const DeepCollectionEquality().hash(_staff));

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
  const factory _CompanyState(
      {final Company company, final List<Profile> staff}) = _$CompanyStateImpl;

  factory _CompanyState.fromJson(Map<String, dynamic> json) =
      _$CompanyStateImpl.fromJson;

  @override
  Company get company;
  @override
  List<Profile> get staff;
  @override
  @JsonKey(ignore: true)
  _$$CompanyStateImplCopyWith<_$CompanyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
