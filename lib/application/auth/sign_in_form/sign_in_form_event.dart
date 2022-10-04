part of 'sign_in_form_bloc.dart';


abstract class SignInFormEvent{
  const SignInFormEvent();
}

class EmailChangedEvent extends SignInFormEvent{
  final String email;
  EmailChangedEvent(this.email);
}

class PasswordChangedEvent extends SignInFormEvent{
  final String password;
  PasswordChangedEvent(this.password);
}

class SignInWithEmailAndPassword extends SignInFormEvent{

  SignInWithEmailAndPassword();
}

class RegisterWithEmailAndPassword extends SignInFormEvent{

  RegisterWithEmailAndPassword();
}

class SignInWithGoogle extends SignInFormEvent{
  const SignInWithGoogle();
}

