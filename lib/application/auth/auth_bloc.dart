import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../domain/auth/I_auth_facade.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade;
  AuthBloc(this._authFacade) : super(InitialState()) {


    on<AuthCheckRequest>((event, emit) async {
      final userOption = _authFacade.getSignedInUser();
      userOption.fold(
        () => emit(UnauthenticatedState()),
        (_) => emit(AuthenticatedState()),
      );
    });


    on<SignedOut>((event, emit) async {
      await _authFacade.signOut();
      emit(UnauthenticatedState());
    });


  }
}
