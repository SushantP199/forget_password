import 'package:forget_password/data/local/base_db_service.dart';
import 'package:forget_password/data/local/local_db_service.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/debug_printer.dart';

class BaseRepository {
  final BaseDbService _baseDbService = LocalDbService();

  Future<Result> saveUserDetail(DataModel dataModel) async {
    Result result;

    try {
      await _baseDbService.getCreateDbResponse(dataModel);
      result = Result(success: true, data: KGlobal.VOID);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> getUserDetail(String id) async {
    Result result;

    try {
      DataModel dataModel = await _baseDbService.getReadDbResponse(id);
      result = Result(success: true, data: dataModel);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> deleteUserDetail(String id) async {
    Result result;

    try {
      await _baseDbService.getDeleteDbResponse(id);
      result = Result(success: true, data: KGlobal.VOID);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> editUserDetail(DataModel dataModel) async {
    Result result;

    try {
      await _baseDbService.getUpdateDbResponse(dataModel);
      result = Result(success: true, data: KGlobal.VOID);
    } catch (e) {
      result = Result(success: false, error: KError.STORERROR);
      DebugPrinter.log(e.toString());
    }

    return result;
  }

  Future<Result> getUserAccounts() async {
    Result result;

    try {
      var dataModels = await _baseDbService.getReadAll();
      result = Result(success: true, data: dataModels);
    } catch (e) {
      DebugPrinter.log(e.toString());
      result = Result(success: false, error: KError.STORERROR);
    }

    return result;
  }
}
