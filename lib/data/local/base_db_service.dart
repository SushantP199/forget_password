abstract class BaseDbService {
  Future<dynamic> getCreateDbResponse(dynamic data);

  Future<dynamic> getReadDbResponse(dynamic id);

  Future<dynamic> getUpdateDbResponse(dynamic data);

  Future<dynamic> getDeleteDbResponse(dynamic id);

  Future<dynamic> getReadAll();
}
