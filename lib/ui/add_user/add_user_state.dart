part of 'add_user_bloc.dart';

@immutable
abstract class AddUserState {
  const AddUserState();
}

class AddUserForm extends AddUserState {
  const AddUserForm();
}
class AddUserLoading extends AddUserState{
  const AddUserLoading();
}
class AddUserSuccess extends AddUserState {
  const AddUserSuccess();
}
class AddUserError extends AddUserState {
  const AddUserError();
}