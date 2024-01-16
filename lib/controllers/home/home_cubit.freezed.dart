// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  HomeTab get tab => throw _privateConstructorUsedError;
  List<Klaim>? get klaimList => throw _privateConstructorUsedError;
  String? get klaimError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({HomeTab tab, List<Klaim>? klaimList, String? klaimError});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
    Object? klaimList = freezed,
    Object? klaimError = freezed,
  }) {
    return _then(_value.copyWith(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as HomeTab,
      klaimList: freezed == klaimList
          ? _value.klaimList
          : klaimList // ignore: cast_nullable_to_non_nullable
              as List<Klaim>?,
      klaimError: freezed == klaimError
          ? _value.klaimError
          : klaimError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HomeTab tab, List<Klaim>? klaimList, String? klaimError});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
    Object? klaimList = freezed,
    Object? klaimError = freezed,
  }) {
    return _then(_$HomeStateImpl(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as HomeTab,
      klaimList: freezed == klaimList
          ? _value._klaimList
          : klaimList // ignore: cast_nullable_to_non_nullable
              as List<Klaim>?,
      klaimError: freezed == klaimError
          ? _value.klaimError
          : klaimError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.tab = HomeTab.hadir, final List<Klaim>? klaimList, this.klaimError})
      : _klaimList = klaimList;

  @override
  @JsonKey()
  final HomeTab tab;
  final List<Klaim>? _klaimList;
  @override
  List<Klaim>? get klaimList {
    final value = _klaimList;
    if (value == null) return null;
    if (_klaimList is EqualUnmodifiableListView) return _klaimList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? klaimError;

  @override
  String toString() {
    return 'HomeState(tab: $tab, klaimList: $klaimList, klaimError: $klaimError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.tab, tab) || other.tab == tab) &&
            const DeepCollectionEquality()
                .equals(other._klaimList, _klaimList) &&
            (identical(other.klaimError, klaimError) ||
                other.klaimError == klaimError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab,
      const DeepCollectionEquality().hash(_klaimList), klaimError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final HomeTab tab,
      final List<Klaim>? klaimList,
      final String? klaimError}) = _$HomeStateImpl;

  @override
  HomeTab get tab;
  @override
  List<Klaim>? get klaimList;
  @override
  String? get klaimError;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
