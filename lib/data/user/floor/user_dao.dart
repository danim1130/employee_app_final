import 'package:employee_app/data/user/floor/user_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserEntity')
  Stream<List<UserEntity>> fetchUserEntities();

  @Query('SELECT * FROM UserEntity WHERE name LIKE :namePattern')
  Stream<List<UserEntity>> searchName(String namePattern);

  @Query('SELECT * FROM UserEntity WHERE id = :id')
  Stream<UserEntity?> fetchUser(int id);

  @insert
  Future<int> insertUserEntity(UserEntity entity);

  @delete
  Future<int> deleteUserEntity(UserEntity entity);
}