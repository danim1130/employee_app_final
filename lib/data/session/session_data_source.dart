import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SessionDataSource{
  static const autoLoginKey = 'autoLogin';

  final SharedPreferences _sharedPreferences;

  SessionDataSource(this._sharedPreferences);

  bool get isAutoLogin => _sharedPreferences.getBool(autoLoginKey) ?? false;
  set isAutoLogin(bool value){
    _sharedPreferences.setBool(autoLoginKey, value);
  }
}