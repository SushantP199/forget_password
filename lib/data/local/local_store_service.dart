import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forget_password/data/local/base_store_service.dart';

class LocalStoreService extends BaseStoreService {
  /*
    Local flutter secure storage Creation
  */
  get store {
    return FlutterSecureStorage();
  }

  /*
    Local storage factory service
  */
  static LocalStoreService? _localStoreService;

  LocalStoreService._createInstance();

  factory LocalStoreService() {
    return _localStoreService ??= LocalStoreService._createInstance();
  }

  /*
    Storage operations
  */
  @override
  Future get(String key) async {
    try {
      String? value = await store.read(key: key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future set(String key, String value) async {
    try {
      await store.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(String key) async {
    try {
      await store.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }
}
