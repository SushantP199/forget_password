abstract class BaseStoreService {
  Future<dynamic> get(String key);

  Future<dynamic> set(String key, String value);

  Future<dynamic> delete(String key);
}
