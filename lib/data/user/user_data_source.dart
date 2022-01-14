import 'dart:async';

import 'package:employee_app/domain/model/user_data.dart';

abstract class UserDataSource{
  Stream<List<UserData>> fetchUserDataList();
  Stream<List<UserData>> searchUser(String name);
  Stream<UserData?> getUser(int userId);
  Future removeUser(int userId);
  Future addUser(UserData user);
}

class UserDataSourceType{
  static const floor = 'floor';
  static const hive = 'hive';
  static const memory = 'memory';
}