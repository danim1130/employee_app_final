import 'dart:async';
import 'package:employee_app/data/user/floor/user_dao.dart';
import 'package:employee_app/data/user/floor/user_entity.dart';
import 'package:employee_app/di/modules/floor_module.dart';
import 'package:employee_app/main.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:injectable/injectable.dart';

import 'package:employee_app/domain/model/user_data.dart';
import 'package:floor/floor.dart';

@Named(UserDataSourceType.floor)
@LazySingleton(as: UserDataSource)
class UserFloorDataSource implements UserDataSource {
  final UserDao _userDao;

  UserFloorDataSource(this._userDao);

  @override
  Stream<List<UserData>> fetchUserDataList() {
    return _userDao
        .fetchUserEntities()
        .map((entities) => entities.map((e) => e.toUserData()).toList());
  }

  @override
  Stream<List<UserData>> searchUser(String name) {
    return _userDao
        .searchName('%$name%')
        .map((entities) => entities.map((e) => e.toUserData()).toList());
  }

  @override
  Future addUser(UserData user) {
    return _userDao.insertUserEntity(UserEntity.fromUserData(user));
  }

  @override
  Future removeUser(int userId) {
    return _userDao.deleteUserEntity(UserEntity(
      userId,
      "name",
      "phone",
      "email",
      UserStatus.worker,
      "avatarUrl",
    ));
  }

  @override
  Stream<UserData?> getUser(int userId) {
    return _userDao.fetchUser(userId).map((entity) => entity?.toUserData());
  }
}
