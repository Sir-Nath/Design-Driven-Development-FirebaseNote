import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:notepad_firebase_ddd/domain/auth/value_objects.dart';
import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/I_auth_facade.dart';
part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {

    @override
    Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
      yield* event.map(
        emailChanged: (e) async* {
          yield state.copyWith(
              emailAddress: EmailAddress(e.emailStr),
              authFailureOrSuccess: none());
        },
        passwordChanged: (e) async* {
          yield state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccess: none(),
          );
        },
        registerWithEmailAndPasswordPressed: (e) async* {
          final isEmailValid = state.emailAddress.isValid();
          final isPasswordValid = state.password.isValid();
          if (isEmailValid && isPasswordValid) {
            yield state.copyWith(
                isSubmitting: true, authFailureOrSuccess: none());
            final failureOrSuccess =
                await _authFacade.registerWithEmailAndPassword(
                    email: state.emailAddress, password: state.password);
            yield state.copyWith(
                isSubmitting: false,
                authFailureOrSuccess: some(failureOrSuccess));
          }
          yield state.copyWith(
              showErrorMessages: true, authFailureOrSuccess: none());
        },
        signInWithEmailAndPasswordPressed: (e) async* {
          final isEmailValid = state.emailAddress.isValid();
          final isPasswordValid = state.password.isValid();
          if (isEmailValid && isPasswordValid) {
            yield state.copyWith(
                isSubmitting: true, authFailureOrSuccess: none());
            final failureOrSuccess =
                await _authFacade.signInWithEmailAndPassword(
              email: state.emailAddress,
              password: state.password,
            );
            yield state.copyWith(
                isSubmitting: false,
                authFailureOrSuccess: some(failureOrSuccess));
          }
          yield state.copyWith(
              showErrorMessages: true, authFailureOrSuccess: none());
        },
        signInWithGooglePressed: (e) async* {
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccess: none(),
          );
          final failureOrSuccess = await _authFacade.signInWithGoogle();
          yield state.copyWith(
              isSubmitting: false,
              authFailureOrSuccess: some(failureOrSuccess));
        },
      );
    }
  }
}
