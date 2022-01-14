part of 'add_user_bloc.dart';

@immutable
abstract class AddUserEvent {
  const AddUserEvent();
}

class AddUserRegisterEvent extends AddUserEvent {
  final UserData userData;

  const AddUserRegisterEvent(this.userData);
}
