import 'package:flamingo/flamingo.dart';

class DocumentClient {
  static DocumentAccessor? _accessor;

  static DocumentAccessor instance() {
    _accessor ??= DocumentAccessor();
    return _accessor!;
  }
}
