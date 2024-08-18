// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvitationState {
  bool get isEmailValid => throw _privateConstructorUsedError;
  PageStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvitationStateCopyWith<InvitationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationStateCopyWith<$Res> {
  factory $InvitationStateCopyWith(
          InvitationState value, $Res Function(InvitationState) then) =
      _$InvitationStateCopyWithImpl<$Res, InvitationState>;
  @useResult
  $Res call({bool isEmailValid, PageStatus status, String? message});
}

/// @nodoc
class _$InvitationStateCopyWithImpl<$Res, $Val extends InvitationState>
    implements $InvitationStateCopyWith<$Res> {
  _$InvitationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailValid = null,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationStateImplCopyWith<$Res>
    implements $InvitationStateCopyWith<$Res> {
  factory _$$InvitationStateImplCopyWith(_$InvitationStateImpl value,
          $Res Function(_$InvitationStateImpl) then) =
      __$$InvitationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEmailValid, PageStatus status, String? message});
}

/// @nodoc
class __$$InvitationStateImplCopyWithImpl<$Res>
    extends _$InvitationStateCopyWithImpl<$Res, _$InvitationStateImpl>
    implements _$$InvitationStateImplCopyWith<$Res> {
  __$$InvitationStateImplCopyWithImpl(
      _$InvitationStateImpl _value, $Res Function(_$InvitationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailValid = null,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(_$InvitationStateImpl(
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InvitationStateImpl
    with DiagnosticableTreeMixin
    implements _InvitationState {
  const _$InvitationStateImpl(
      {this.isEmailValid = false, this.status = PageStatus.idle, this.message});

  @override
  @JsonKey()
  final bool isEmailValid;
  @override
  @JsonKey()
  final PageStatus status;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvitationState(isEmailValid: $isEmailValid, status: $status, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvitationState'))
      ..add(DiagnosticsProperty('isEmailValid', isEmailValid))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationStateImpl &&
            (identical(other.isEmailValid, isEmailValid) ||
                other.isEmailValid == isEmailValid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEmailValid, status, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationStateImplCopyWith<_$InvitationStateImpl> get copyWith =>
      __$$InvitationStateImplCopyWithImpl<_$InvitationStateImpl>(
          this, _$identity);
}

abstract class _InvitationState implements InvitationState {
  const factory _InvitationState(
      {final bool isEmailValid,
      final PageStatus status,
      final String? message}) = _$InvitationStateImpl;

  @override
  bool get isEmailValid;
  @override
  PageStatus get status;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$InvitationStateImplCopyWith<_$InvitationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
