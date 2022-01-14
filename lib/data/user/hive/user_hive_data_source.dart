import 'package:employee_app/data/user/hive/user_object.dart';
import 'package:employee_app/di/modules/hive_module.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Named(UserDataSourceType.hive)
@LazySingleton(as: UserDataSource)
class UserHiveDataSource implements UserDataSource {
  final Box<UserObject> _box;

  UserHiveDataSource(this._box);

  @override
  Future addUser(UserData user) {
    return _box.put(user.id, UserObject.fromUserData(user));
  }

  @override
  Future removeUser(int userId) {
    return _box.delete(userId);
  }

  @override
  Stream<List<UserData>> fetchUserDataList() {
    return Stream.value(_box.values)
        .concatWith([_box.watch().map((event) => _box.values.toList())]).map(
      (objects) {
        return objects
            .map(
              (e) => e.toUserData(),
            )
            .toList();
      },
    );
  }

  @override
  Stream<List<UserData>> searchUser(String name) {
    return fetchUserDataList().map(
      (users) => users
          .where(
            (element) => element.name.contains(name),
          )
          .toList(),
    );
  }

  @override
  Stream<UserData?> getUser(int userId) {
    return Stream.value(_box.get(userId)).concatWith([
      _box.watch(key: userId).map((event) => event.value as UserObject?)
    ]).map((userObj) => userObj?.toUserData());
  }
}
