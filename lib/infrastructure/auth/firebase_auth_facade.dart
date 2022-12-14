import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notepad_firebase_ddd/domain/auth/auth_failure.dart';
import 'package:notepad_firebase_ddd/domain/auth/value_objects.dart';
import 'package:notepad_firebase_ddd/infrastructure/auth/firebase_user_mapper.dart';
import '../../domain/auth/I_auth_facade.dart';
import '../../domain/auth/user.dart';

//this is a firebase implementation of the IAuthFacade

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
    } on PlatformException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUSer = await _googleSignIn.signIn();
      if (googleUSer == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUSer.authentication;

      final authCredentials = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      return _firebaseAuth
          .signInWithCredential(authCredentials)
          .then((r) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Option<AuthUser> getSignedInUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return optionOf((firebaseUser?.toDomain()));
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
