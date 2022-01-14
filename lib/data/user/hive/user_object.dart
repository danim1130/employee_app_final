import 'package:employee_app/domain/model/user_data.dart';
import 'package:hive/hive.dart';

part 'user_object.g.dart';

@HiveType(typeId: 0)
class UserObject extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final UserStatusObject status;
  @HiveField(5)
  final String avatarUrl;

  UserObject(
      this.id, this.name, this.phone, this.email, this.status, this.avatarUrl);

  UserData toUserData() {
    return UserData(
      id,
      name,
      email,
      phone,
      UserStatus.values.byName(status.name),
      avatarUrl,
    );
  }

  factory UserObject.fromUserData(UserData data) {
    return UserObject(
      data.id,
      data.name,
      data.phone,
      data.email,
      UserStatusObject.values.byName(data.status.name),
      data.avatarUrl,
    );
  }
}

@HiveType(typeId: 1)
enum UserStatusObject {
@HiveField(0)
worker,
@HiveField(1)
manager,
}