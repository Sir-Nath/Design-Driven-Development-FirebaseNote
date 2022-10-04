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

    on<EmailChangedEvent>((event, emit){
      emit(state.copyWith(
          emailAddress: EmailAddress(event.email),
          authFailureOrSuccess: none()
      ));
    });

    on<PasswordChangedEvent>((event, emit){
      emit(
          state.copyWith(
              password: Password(event.password),
              authFailureOrSuccess: none())
      );
    });

    on<SignInWithEmailAndPassword>((event, emit)async{
      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();
      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
            isSubmitting: true, authFailureOrSuccess: none()));
        final failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
            email: state.emailAddress, password: state.password);
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccess: some(failureOrSuccess)));
      }
      emit(state.copyWith(
          showErrorMessages: true, authFailureOrSuccess: none()));
    });

    on<RegisterWithEmailAndPassword>((event, emit)async{
      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();
      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
            isSubmitting: true, authFailureOrSuccess: none()));
        final failureOrSuccess =  await _authFacade.registerWithEmailAndPassword(
            email: state.emailAddress, password: state.password);
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccess: some(failureOrSuccess)));
      }
      emit(state.copyWith(
          showErrorMessages: true, authFailureOrSuccess: none()));
    });

    on<SignInWithGoogle>((event, emit)async{
      emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccess: none(),
          )
      );
      final failureOrSuccess = await _authFacade.signInWithGoogle();
      emit(state.copyWith(
          isSubmitting: false,
          authFailureOrSuccess: some(failureOrSuccess)));
    });
  }

}
