import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:notepad_firebase_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:notepad_firebase_ddd/domain/auth/I_auth_facade.dart';
import 'package:notepad_firebase_ddd/infrastructure/auth/firebase_auth_facade.dart';
import 'package:notepad_firebase_ddd/injection.config.dart';

final GetIt getIt = GetIt.instance;

void configureInjection()async {
  getIt.registerFactory(() => SignInFormBloc(getIt()));
  getIt.registerLazySingleton<IAuthFacade>(() => FirebaseAuthFacade(getIt<FirebaseAuth>(), getIt<GoogleSignIn>()));
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());


}