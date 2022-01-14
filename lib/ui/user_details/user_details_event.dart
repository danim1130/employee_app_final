part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsEvent {
  const UserDetailsEvent();
}

class UserDetailsLoadEvent extends UserDetailsEvent {
  final int userId;

  const UserDetailsLoadEvent(this.userId);
}

class UserDetailsDeleteUser extends UserDetailsEvent {
  final UserData user;

  const UserDetailsDeleteUser(this.user);
}
