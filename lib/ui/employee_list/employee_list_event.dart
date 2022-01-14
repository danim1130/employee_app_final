part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent extends Equatable {
  const EmployeeListEvent();
}

abstract class EmployeeListShowEvent extends EmployeeListEvent{
  const EmployeeListShowEvent();
}

class EmployeeListLoadListEvent extends EmployeeListShowEvent{
  const EmployeeListLoadListEvent();

  @override
  List<Object?> get props => [];
}

class EmployeeListUserSelected extends EmployeeListEvent{
  final UserData? selectedUser;

  const EmployeeListUserSelected(this.selectedUser);

  @override
  List<Object?> get props => [selectedUser];
}

class EmployeeListSearch extends EmployeeListShowEvent{
  final String searchTerm;

  const EmployeeListSearch(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];

}
