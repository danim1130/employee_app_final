import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_app/domain/interactor/login_interactor.dart';
import 'package:employee_app/main.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor _loginInteractor;

  LoginBloc(this._loginInteractor) : super(const LoginInput()) {
    on<LoginStartLogin>((event, emit) async{
      emit(const LoginLoading());
      try {
        await _loginInteractor.loginUser(event.email, event.password, event.isAutoLogin);
        emit(const LoginFinished(null, true));
      } catch(e) {
        emit(LoginFinished(e, false));
      }
    });
    on<LoginStartAutoLogin>((event, emit) async{
      emit(const LoginLoading());
      var loggedIn = await _loginInteractor.tryAutoLoginUser();
      if (loggedIn) {
        emit(const LoginFinished(null, true));
      } else {
        emit(const LoginInput());
      }
    });
    add(LoginStartAutoLogin());
  }
}
