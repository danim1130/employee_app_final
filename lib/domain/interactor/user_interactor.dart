import 'package:employee_app/data/randomuser/remote_user_data_source.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserInteractor {
  final UserDataSource _userDataSource;
  final RemoteUserDataSource _remoteUserDataSource;

  UserInteractor(
    @Named(UserDataSourceType.hive) this._userDataSource,
    this._remoteUserDataSource,
  ) {
    _initializeDataSource();
  }

  Future _initializeDataSource() async {
    var initialList = await _userDataSource.fetchUserDataList().first;
    if (initialList.isEmpty) {
      var loadedList = await _remoteUserDataSource.fetchInitialUserList();
      for (var user in loadedList){
        addUser(user);
      }
    }
  }

  Future addUser(UserData user) {
    return _userDataSource.addUser(user);
  }

  Stream<UserData?> getUser(int userId){
    return _userDataSource.getUser(userId);
  }

  Stream<List<UserData>> getAllUser(){
    return _userDataSource.fetchUserDataList();
  }

  Future deleteUser(UserData user) {
    return _userDataSource.removeUser(user.id);
  }

  Stream<List<UserData>> searchUser(String searchTerm) {
    return _userDataSource.searchUser(searchTerm);
  }
}
