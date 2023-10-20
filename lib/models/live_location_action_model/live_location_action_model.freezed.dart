// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_location_action_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LiveLocationActionModel _$LiveLocationActionModelFromJson(
    Map<String, dynamic> json) {
  return _LiveLocationActionModel.fromJson(json);
}

/// @nodoc
mixin _$LiveLocationActionModel {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  dynamic Function()? get onPressed => throw _privateConstructorUsedError;
  bool get isBreak => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveLocationActionModelCopyWith<LiveLocationActionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveLocationActionModelCopyWith<$Res> {
  factory $LiveLocationActionModelCopyWith(LiveLocationActionModel value,
          $Res Function(LiveLocationActionModel) then) =
      _$LiveLocationActionModelCopyWithImpl<$Res, LiveLocationActionModel>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      bool isActive,
      @JsonKey(includeToJson: false, includeFromJson: false)
      dynamic Function()? onPressed,
      bool isBreak});
}

/// @nodoc
class _$LiveLocationActionModelCopyWithImpl<$Res,
        $Val extends LiveLocationActionModel>
    implements $LiveLocationActionModelCopyWith<$Res> {
  _$LiveLocationActionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? isActive = null,
    Object? onPressed = freezed,
    Object? isBreak = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      onPressed: freezed == onPressed
          ? _value.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      isBreak: null == isBreak
          ? _value.isBreak
          : isBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveLocationActionModelImplCopyWith<$Res>
    implements $LiveLocationActionModelCopyWith<$Res> {
  factory _$$LiveLocationActionModelImplCopyWith(
          _$LiveLocationActionModelImpl value,
          $Res Function(_$LiveLocationActionModelImpl) then) =
      __$$LiveLocationActionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      bool isActive,
      @JsonKey(includeToJson: false, includeFromJson: false)
      dynamic Function()? onPressed,
      bool isBreak});
}

/// @nodoc
class __$$LiveLocationActionModelImplCopyWithImpl<$Res>
    extends _$LiveLocationActionModelCopyWithImpl<$Res,
        _$LiveLocationActionModelImpl>
    implements _$$LiveLocationActionModelImplCopyWith<$Res> {
  __$$LiveLocationActionModelImplCopyWithImpl(
      _$LiveLocationActionModelImpl _value,
      $Res Function(_$LiveLocationActionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? isActive = null,
    Object? onPressed = freezed,
    Object? isBreak = null,
  }) {
    return _then(_$LiveLocationActionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      onPressed: freezed == onPressed
          ? _value.onPressed
          : onPressed // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      isBreak: null == isBreak
          ? _value.isBreak
          : isBreak // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveLocationActionModelImpl implements _LiveLocationActionModel {
  const _$LiveLocationActionModelImpl(
      {this.id,
      this.title,
      this.isActive = false,
      @JsonKey(includeToJson: false, includeFromJson: false) this.onPressed,
      this.isBreak = false});

  factory _$LiveLocationActionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveLocationActionModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final dynamic Function()? onPressed;
  @override
  @JsonKey()
  final bool isBreak;

  @override
  String toString() {
    return 'LiveLocationActionModel(id: $id, title: $title, isActive: $isActive, onPressed: $onPressed, isBreak: $isBreak)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveLocationActionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed) &&
            (identical(other.isBreak, isBreak) || other.isBreak == isBreak));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, isActive, onPressed, isBreak);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveLocationActionModelImplCopyWith<_$LiveLocationActionModelImpl>
      get copyWith => __$$LiveLocationActionModelImplCopyWithImpl<
          _$LiveLocationActionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveLocationActionModelImplToJson(
      this,
    );
  }
}

abstract class _LiveLocationActionModel implements LiveLocationActionModel {
  const factory _LiveLocationActionModel(
      {final int? id,
      final String? title,
      final bool isActive,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final dynamic Function()? onPressed,
      final bool isBreak}) = _$LiveLocationActionModelImpl;

  factory _LiveLocationActionModel.fromJson(Map<String, dynamic> json) =
      _$LiveLocationActionModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  bool get isActive;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  dynamic Function()? get onPressed;
  @override
  bool get isBreak;
  @override
  @JsonKey(ignore: true)
  _$$LiveLocationActionModelImplCopyWith<_$LiveLocationActionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
