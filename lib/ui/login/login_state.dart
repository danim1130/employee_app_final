part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();
}

class LoginInput extends LoginState {
  const LoginInput();

  @override
  List<Object?> get props => [];
}
class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object?> get props => [];
}
class LoginFinished extends LoginState {
  final Object? error;
  final bool successfullyFinished;

  const LoginFinished(this.error, this.successfullyFinished);

  @override
  List<Object?> get props => [error, successfullyFinished];
}
