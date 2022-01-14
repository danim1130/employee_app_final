import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:employee_app/data/user/user_data_source.dart';
import 'package:employee_app/domain/interactor/user_interactor.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'employee_list_event.dart';

part 'employee_list_state.dart';

@injectable
class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc(UserInteractor userInteractor)
      : super(const EmployeeListLoaded([], null)) {

    on<EmployeeListUserSelected>((event, emit) {
      var currentState = state;
      if (currentState is EmployeeListSearchResult){
        emit(EmployeeListSearchResult(currentState.users, event.selectedUser));
      } else if (currentState is EmployeeListLoaded) {
        emit(EmployeeListLoaded(currentState.users, event.selectedUser));
      }
    });
    on<EmployeeListShowEvent>((event, emit) async {
      if (event is EmployeeListLoadListEvent){
        var userListStream = userInteractor.getAllUser();
        await emit.forEach<List<UserData>>(userListStream, onData: (userList){
          var currentState = state;
          var selectedUser =
          currentState is EmployeeListLoaded ? currentState.selectedUser : null;
          return EmployeeListLoaded(userList, selectedUser);
        });
      } else if (event is EmployeeListSearch){
        var userListStream = userInteractor.searchUser(event.searchTerm);
        await emit.forEach<List<UserData>>(userListStream, onData: (userList){
          var currentState = state;
          var selectedUser =
          currentState is EmployeeListLoaded ? currentState.selectedUser : null;
          return EmployeeListSearchResult(userList, selectedUser);
        });
      }
    }, transformer: (events, mapper) {
      return events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper);
    });
  }
}
