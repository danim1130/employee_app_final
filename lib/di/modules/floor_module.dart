import 'dart:async';

import 'package:employee_app/data/user/floor/user_dao.dart';
import 'package:employee_app/data/user/floor/user_entity.dart';
import 'package:employee_app/data/user/floor/user_status_converter.dart';
import 'package:employee_app/environment.dart';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floor_module.g.dart';

@TypeConverters([UserStatusTypeConverter])
@Database(version: 1, entities: [UserEntity])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}

@module
abstract class FloorModule {
  @notWeb
  @preResolve
  Future<AppDatabase> appDatabase(AppEnvironment app) async {
    return await $FloorAppDatabase
        .databaseBuilder(app.databaseFileName)
        .build();
  }

  UserDao userDao(AppDatabase appDatabase) => appDatabase.userDao;
}
