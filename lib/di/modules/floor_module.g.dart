// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_module.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `phone` TEXT NOT NULL, `email` TEXT NOT NULL, `status` TEXT NOT NULL, `avatarUrl` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'UserEntity',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'email': item.email,
                  'status': _userStatusTypeConverter.encode(item.status),
                  'avatarUrl': item.avatarUrl
                },
            changeListener),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'UserEntity',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'email': item.email,
                  'status': _userStatusTypeConverter.encode(item.status),
                  'avatarUrl': item.avatarUrl
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Stream<List<UserEntity>> fetchUserEntities() {
    return _queryAdapter.queryListStream('SELECT * FROM UserEntity',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['phone'] as String,
            row['email'] as String,
            _userStatusTypeConverter.decode(row['status'] as String),
            row['avatarUrl'] as String),
        queryableName: 'UserEntity',
        isView: false);
  }

  @override
  Stream<List<UserEntity>> searchName(String namePattern) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM UserEntity WHERE name LIKE ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['phone'] as String,
            row['email'] as String,
            _userStatusTypeConverter.decode(row['status'] as String),
            row['avatarUrl'] as String),
        arguments: [namePattern],
        queryableName: 'UserEntity',
        isView: false);
  }

  @override
  Stream<UserEntity?> fetchUser(int id) {
    return _queryAdapter.queryStream('SELECT * FROM UserEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            row['id'] as int,
            row['name'] as String,
            row['phone'] as String,
            row['email'] as String,
            _userStatusTypeConverter.decode(row['status'] as String),
            row['avatarUrl'] as String),
        arguments: [id],
        queryableName: 'UserEntity',
        isView: false);
  }

  @override
  Future<int> insertUserEntity(UserEntity entity) {
    return _userEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteUserEntity(UserEntity entity) {
    return _userEntityDeletionAdapter.deleteAndReturnChangedRows(entity);
  }
}

// ignore_for_file: unused_element
final _userStatusTypeConverter = UserStatusTypeConverter();
