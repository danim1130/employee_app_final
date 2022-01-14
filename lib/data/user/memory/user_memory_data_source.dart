import 'dart:async';

import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:collection/collection.dart';

@Named(UserDataSourceType.memory)
@LazySingleton(as: UserDataSource)
class UserMemoryDataSource implements UserDataSource {
  final StreamController<List<UserData>> _streamController = BehaviorSubject();
  List<UserData> _currentUserList = [];

  UserMemoryDataSource() {
    _streamController.add(_currentUserList);
  }

  @override
  Stream<List<UserData>> fetchUserDataList() {
    return _streamController.stream;
  }

  @override
  Stream<List<UserData>> searchUser(String name) {
    return fetchUserDataList().map((element) =>
        element.where((element) => element.name.contains(name)).toList());
  }

  @override
  Future removeUser(int userId) async {
    _currentUserList = _currentUserList.toList()
      ..removeWhere((element) => element.id == userId);
    _streamController.add(_currentUserList);
  }

  @override
  Future addUser(UserData user) async {
    _currentUserList = _currentUserList.toList()..add(user);
    _streamController.add(_currentUserList);
  }

  @override
  Stream<UserData?> getUser(int userId) {
    return _streamController.stream
        .map((userList) =>
            userList.firstWhereOrNull((element) => element.id == userId))
        .distinct();
  }
}
