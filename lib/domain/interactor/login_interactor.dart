import 'package:employee_app/data/session/session_data_source.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginInteractor{
  final SessionDataSource sessionDataSource;

  LoginInteractor(this.sessionDataSource);

  Future loginUser(String email, String password, bool setAutoLogin) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'dani@example.com' && password == '12'){
      sessionDataSource.isAutoLogin = setAutoLogin;
      return;
    } else {
      throw Exception('Incorrect user!');
    }
  }

  Future<bool> tryAutoLoginUser() async {
    return sessionDataSource.isAutoLogin;
  }
}