// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i8;
import 'package:flutter_bloc/flutter_bloc.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i13;
import 'package:hive_flutter/hive_flutter.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../data/randomuser/remote_user_data_source.dart' as _i9;
import '../data/session/session_data_source.dart' as _i19;
import '../data/user/floor/user_dao.dart' as _i20;
import '../data/user/floor/user_floor_data_source.dart' as _i21;
import '../data/user/hive/user_hive_data_source.dart' as _i12;
import '../data/user/hive/user_object.dart' as _i7;
import '../data/user/memory/user_memory_data_source.dart' as _i14;
import '../data/user/user_data_source.dart' as _i11;
import '../domain/interactor/login_interactor.dart' as _i23;
import '../domain/interactor/user_interactor.dart' as _i15;
import '../environment.dart' as _i3;
import '../ui/add_user/add_user_bloc.dart' as _i16;
import '../ui/employee_list/employee_list_bloc.dart' as _i18;
import '../ui/login/login_bloc.dart' as _i24;
import '../ui/user_details/user_details_bloc.dart' as _i22;
import '../util/bloc_observer.dart' as _i5;
import 'modules/floor_module.dart' as _i17;
import 'modules/hive_module.dart' as _i25;
import 'modules/network_module.dart' as _i26;
import 'modules/shared_preferences_module.dart' as _i27;

const String _notWeb = 'notWeb';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final hiveModule = _$HiveModule();
  final networkModule = _$NetworkModule();
  final sharedPreferencesModule = _$SharedPreferencesModule();
  final floorModule = _$FloorModule();
  gh.singleton<_i3.AppEnvironment>(_i3.ProdEnvironment());
  gh.factory<_i4.BlocObserver>(() => _i5.MyBlocObserver());
  await gh.factoryAsync<_i6.Box<_i7.UserObject>>(() => hiveModule.userBox,
      preResolve: true);
  gh.singleton<_i8.Dio>(networkModule.dio(get<_i3.AppEnvironment>()));
  gh.factory<_i9.RemoteUserDataSource>(
      () => _i9.RemoteUserDataSource(get<_i8.Dio>()));
  await gh.factoryAsync<_i10.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i11.UserDataSource>(
      () => _i12.UserHiveDataSource(get<_i13.Box<_i7.UserObject>>()),
      instanceName: 'hive');
  gh.lazySingleton<_i11.UserDataSource>(() => _i14.UserMemoryDataSource(),
      instanceName: 'memory');
  gh.lazySingleton<_i15.UserInteractor>(() => _i15.UserInteractor(
      get<_i11.UserDataSource>(instanceName: 'hive'),
      get<_i9.RemoteUserDataSource>()));
  gh.factory<_i16.AddUserBloc>(
      () => _i16.AddUserBloc(get<_i15.UserInteractor>()));
  await gh.factoryAsync<_i17.AppDatabase>(
      () => floorModule.appDatabase(get<_i3.AppEnvironment>()),
      registerFor: {_notWeb},
      preResolve: true);
  gh.factory<_i18.EmployeeListBloc>(
      () => _i18.EmployeeListBloc(get<_i15.UserInteractor>()));
  gh.singleton<_i19.SessionDataSource>(
      _i19.SessionDataSource(get<_i10.SharedPreferences>()));
  gh.factory<_i20.UserDao>(() => floorModule.userDao(get<_i17.AppDatabase>()));
  gh.lazySingleton<_i11.UserDataSource>(
      () => _i21.UserFloorDataSource(get<_i20.UserDao>()),
      instanceName: 'floor');
  gh.factory<_i22.UserDetailsBloc>(
      () => _i22.UserDetailsBloc(get<_i15.UserInteractor>()));
  gh.singleton<_i23.LoginInteractor>(
      _i23.LoginInteractor(get<_i19.SessionDataSource>()));
  gh.factory<_i24.LoginBloc>(() => _i24.LoginBloc(get<_i23.LoginInteractor>()));
  return get;
}

class _$HiveModule extends _i25.HiveModule {}

class _$NetworkModule extends _i26.NetworkModule {}

class _$SharedPreferencesModule extends _i27.SharedPreferencesModule {}

class _$FloorModule extends _i17.FloorModule {}
