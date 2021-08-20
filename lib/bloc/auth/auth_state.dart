part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class NotAuthenticatedState extends AuthState {}
