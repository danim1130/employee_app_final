import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:employee_app/domain/interactor/user_interactor.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

@injectable
class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc(UserInteractor userInteractor)
      : super(const UserDetailsLoaded(null)) {
    on<UserDetailsLoadEvent>(
      (event, emit) async {
        await emit.forEach<UserData?>(
          userInteractor.getUser(event.userId),
          onData: (data) => UserDetailsLoaded(data),
        );
      },
      transformer: restartable(),
    );
    on<UserDetailsDeleteUser>((event, emit) async {
      await userInteractor.deleteUser(event.user);
    });
  }
}
