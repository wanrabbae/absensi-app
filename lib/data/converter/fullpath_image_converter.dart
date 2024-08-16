import 'package:app/helpers/constant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FullPathImageConverter extends JsonConverter<String, String> {
  const FullPathImageConverter();

  @override
  String fromJson(String json) {
    return changeUrlImage(json);
  }

  @override
  String toJson(String object) {
    return object;
  }
}