part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class InitialState extends AuthState {}
class AuthenticatedState extends AuthState {}
class UnauthenticatedState extends AuthState {}
