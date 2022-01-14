part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsState {
  const UserDetailsState();
}

class UserDetailsLoaded extends UserDetailsState with EquatableMixin {
  final UserData? userData;

  const UserDetailsLoaded(this.userData);

  @override
  List<Object?> get props => [userData];
}