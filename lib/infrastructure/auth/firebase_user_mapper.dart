import 'package:firebase_auth/firebase_auth.dart';
import 'package:notepad_firebase_ddd/core/value_object.dart';
import 'package:notepad_firebase_ddd/domain/auth/user.dart';

extension FirebaseUserDomainX on User{
  AuthUser toDomain(){
    return AuthUser(id: UniqueId.fromUniqueString(uid));
  }
}