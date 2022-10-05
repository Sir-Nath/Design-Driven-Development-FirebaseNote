part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthCheckRequest extends AuthEvent{
  const AuthCheckRequest();
}

class SignedOut extends AuthEvent{
  const SignedOut();
}
