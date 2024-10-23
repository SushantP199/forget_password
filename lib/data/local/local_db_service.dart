import 'dart:io';
import 'package:forget_password/model/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'base_db_service.dart';
import 'package:hive/hive.dart';

class LocalDbService extends BaseDbService {
  /*
    Local Database Hive Creation
  */
  Future<Box> initializeDatabase() async {
    Directory appHomeDirectory = await getApplicationDocumentsDirectory();

    Hive.init(appHomeDirectory.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DataModelAdapter());
    }

    return await Hive.openBox<UserModel>("ForgetPasswordBox");
  }

  static Box<dynamic>? _forgetPasswordBox;

  Future get database async {
    return _forgetPasswordBox ??= await initializeDatabase();
  }

  /*
    Local Database Factory Service For Database Operations
  */
  static LocalDbService? _localDbService;

  LocalDbService._createInstance();

  factory LocalDbService() {
    return _localDbService ??= LocalDbService._createInstance();
  }

  /*
    Database Operations
  */
  @override
  Future getCreateDbResponse(dynamic data) async {
    try {
      var db = await database;
      await db.put(data.id, data.userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getReadDbResponse(dynamic id) async {
    try {
      var db = await database;
      var data = await db.get(id);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getUpdateDbResponse(dynamic data) async {
    try {
      var db = await database;
      await db.put(data.id, data.userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getDeleteDbResponse(dynamic id) async {
    try {
      var db = await database;
      await db.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getReadAll() async {
    try {
      var db = await database;
      var values = await db.keys.map((e) async {
        UserModel userModel = await getReadDbResponse(e);
        return DataModel(e, userModel);
      }).toList();
      return values;
    } catch (e) {
      rethrow;
    }
  }
}
