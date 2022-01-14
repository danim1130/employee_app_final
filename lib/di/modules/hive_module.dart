import 'package:employee_app/data/user/hive/user_object.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

typedef UserObjectBox = Box<UserObject>;

@module
abstract class HiveModule{
  @preResolve
  Future<Box<UserObject>> get userBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserObjectAdapter());
    Hive.registerAdapter(UserStatusObjectAdapter());
    return await Hive.openBox<UserObject>('users');
  }
}