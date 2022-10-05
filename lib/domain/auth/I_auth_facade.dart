import 'package:dartz/dartz.dart';
import 'package:notepad_firebase_ddd/domain/auth/auth_failure.dart';
import 'package:notepad_firebase_ddd/domain/auth/user.dart';
import 'package:notepad_firebase_ddd/domain/auth/value_objects.dart';

//this is the contract of the functions we want to perform on authentication
//any implementation that will be used will have these methods

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Option<AuthUser> getSignedInUser();

  Future<void> signOut();
}
