import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_app/domain/interactor/user_interactor.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

@injectable
class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc(UserInteractor userInteractor) : super(const AddUserForm()) {
    on<AddUserRegisterEvent>((event, emit) async {
      try{
        emit(const AddUserLoading());
        await userInteractor.addUser(event.userData);
        emit(const AddUserSuccess());
      } catch(e) {
        emit(const AddUserError());
      } finally {
        emit(const AddUserForm());
      }
    });
  }
}
