part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginStartLogin extends LoginEvent with EquatableMixin{
  final String email;
  final String password;
  final bool isAutoLogin;

  LoginStartLogin(this.email, this.password, this.isAutoLogin);

  @override
  List<Object?> get props => [email, password, isAutoLogin];
}
class LoginStartAutoLogin extends LoginEvent{}
