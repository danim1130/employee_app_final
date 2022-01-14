part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();
}

class EmployeeListLoading extends EmployeeListState {
  const EmployeeListLoading();

  @override
  List<Object> get props => [];
}

class EmployeeListLoaded extends EmployeeListState {
  final List<UserData> users;
  final UserData? selectedUser;

  const EmployeeListLoaded(this.users, this.selectedUser);

  @override
  List<Object?> get props => [users, selectedUser];
}

class EmployeeListSearchResult extends EmployeeListLoaded {
  const EmployeeListSearchResult(List<UserData> users, UserData? selectedUser) : super(users, selectedUser);
}
