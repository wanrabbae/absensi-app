import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_location_action_model.freezed.dart';
part 'live_location_action_model.g.dart';

@freezed
class LiveLocationActionModel with _$LiveLocationActionModel {
  const factory LiveLocationActionModel({
    int? id,
    String? title,
    @Default(false) bool isActive,
    @JsonKey(includeToJson: false, includeFromJson: false) Function()? onPressed,
    @Default(false) bool isBreak,
  }) = _LiveLocationActionModel;

  factory LiveLocationActionModel.fromJson(Map<String, dynamic> json) => _$LiveLocationActionModelFromJson(json);
}
