import 'package:employee_app/data/randomuser/remote_user_data_source.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/domain/interactor/user_interactor.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UserDataSourceMock extends Mock implements UserDataSource {}

class RemoteUserDataSourceMock extends Mock implements RemoteUserDataSource {}

void main() {
  group('UserInteractor initialization logic', () {
    registerFallbackValue(
      const UserData(
        0,
        'Test',
        'Test',
        'Test',
        UserStatus.worker,
        'test',
      ),
    );
    test('Load initial list when UserDataSource empty', () async {
      var uds = UserDataSourceMock();
      when(() => uds.fetchUserDataList())
          .thenAnswer((invocation) => Stream<List<UserData>>.value([]));
      when(() => uds.addUser(any()))
          .thenAnswer((invocation) => Future.value(null));

      var initialUserList = const [
        UserData(
          0,
          'Test',
          'Test',
          'Test',
          UserStatus.worker,
          'test',
        ),
        UserData(
          1,
          'Test',
          'Test',
          'Test',
          UserStatus.worker,
          'test',
        ),
      ];
      var rds = RemoteUserDataSourceMock();
      when(() => rds.fetchInitialUserList())
          .thenAnswer((invocation) => Future.value(initialUserList));

      var interactor = UserInteractor(uds, rds);
      await Future.delayed(const Duration(microseconds: 10));
      verify(() => rds.fetchInitialUserList());

      var paramaterList = verify(() => uds.addUser(captureAny())).captured;
      expect(paramaterList, initialUserList);
    });
    test('Fetch initial list not called when datasource contains users', () async {
      var initialUserList = const [
        UserData(
          0,
          'Test',
          'Test',
          'Test',
          UserStatus.worker,
          'test',
        ),
        UserData(
          1,
          'Test',
          'Test',
          'Test',
          UserStatus.worker,
          'test',
        ),
      ];
      var uds = UserDataSourceMock();
      when(() => uds.fetchUserDataList())
          .thenAnswer((invocation) => Stream<List<UserData>>.value(initialUserList));

      var rds = RemoteUserDataSourceMock();

      var interactor = UserInteractor(uds, rds);
      await Future.delayed(const Duration(microseconds: 10));
      verifyNever(() => rds.fetchInitialUserList());
      verifyNever(() => uds.addUser(captureAny()));
    });
  });
}
