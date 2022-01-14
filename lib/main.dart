import 'package:employee_app/di/inject.dart';
import 'package:employee_app/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await configureDependencies();
  BlocOverrides.runZoned(
    () => runApp(const MainApp()),
    blocObserver: getIt<BlocObserver>(),
  );
}
