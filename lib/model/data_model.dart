import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class DataModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  UserModel userModel;

  DataModel(this.id, this.userModel);
}

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String account;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  UserModel(this.account, this.username, this.password);
}
