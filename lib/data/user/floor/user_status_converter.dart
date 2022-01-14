import 'package:employee_app/domain/model/user_data.dart';
import 'package:floor/floor.dart';

class UserStatusTypeConverter extends TypeConverter<UserStatus, String> {
  @override
  UserStatus decode(String databaseValue) {
    return UserStatus.values.byName(databaseValue);
  }

  @override
  String encode(UserStatus value) {
    return value.name;
  }
}