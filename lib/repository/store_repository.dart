import 'package:forget_password/data/local/base_store_service.dart';
import 'package:forget_password/data/local/local_store_service.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/debug_printer.dart';

class StoreRepository {
  final BaseStoreService _baseStoreService = LocalStoreService();

  Future<Result> set(String key, String value) async {
    Result result;

    try {
      await _baseStoreService.set(key, value);
      result = Result(success: true, data: KGlobal.VOID);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> get(String key) async {
    Result result;

    try {
      String? value = await _baseStoreService.get(key);
      result = Result(success: true, data: value);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> delete(String key) async {
    Result result;

    try {
      await _baseStoreService.delete(key);
      result = Result(success: true, data: KGlobal.VOID);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }
}
