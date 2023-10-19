import 'package:get_storage/get_storage.dart';

class GetStorageClient {
  static GetStorage? _getStorage;

  static GetStorage instance() {
    return _getStorage ??= GetStorage();
  }
}
