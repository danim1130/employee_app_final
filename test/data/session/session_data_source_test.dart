import 'package:employee_app/data/session/session_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMocked extends Mock implements SharedPreferences {}

class SharedPreferencesTrueAutoLoginFake extends Fake
    implements SharedPreferences {
  @override
  bool getBool(String key) {
    if (key == SessionDataSource.autoLoginKey) {
      return true;
    } else {
      return false;
    }
  }
}

void main() {
  group('Test SessionDataSource interaction with SharedPreferences', () {
    test('Test setting auto-login value', () {
      var sp = SharedPreferencesMocked();
      when(() => sp.setBool(SessionDataSource.autoLoginKey, any()))
          .thenAnswer((_) async {
        return true;
      });

      var session = SessionDataSource(sp);
      session.isAutoLogin = true;
      session.isAutoLogin = false;

      var captured = verify(() => sp.setBool(any(), captureAny())).captured;
      expect(captured, equals([true, false]));

      /*verifyInOrder([
        () => sp.setBool(SessionDataSource.autoLoginKey, true),
        () => sp.setBool(SessionDataSource.autoLoginKey, false),
      ]);*/
    });
  });
  test('Test reading the auto-login value', () {
    var sp = SharedPreferencesTrueAutoLoginFake();
    var session = SessionDataSource(sp);
    var result = session.isAutoLogin;
    expect(result, true);
  });
}
