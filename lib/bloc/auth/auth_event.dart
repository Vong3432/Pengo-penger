part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent(this.phone, this.password);
  final String phone;
  final String password;
}

class RegisterEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
