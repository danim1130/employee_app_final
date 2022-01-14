import 'dart:async';

import 'package:employee_app/di/inject.config.dart';
import 'package:employee_app/di/modules/hive_module.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(ignoreUnregisteredTypes: [UserObjectBox])
FutureOr configureDependencies() async {
  return $initGetIt(
    getIt,
    environmentFilter: NoEnvOrContains(kIsWeb ? 'web' : 'notWeb'),
  );
}
