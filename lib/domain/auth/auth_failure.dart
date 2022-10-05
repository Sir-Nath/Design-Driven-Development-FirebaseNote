import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_failure.freezed.dart';

//there are different Auth Failure classes.
//this is the same as defining an abstract class AuthFailure and implementing it on other AuthFailure Class

@freezed
abstract class AuthFailure with _$AuthFailure{
  const factory AuthFailure.cancelledByUser() = CancelledByUser;
  const factory AuthFailure.serverError() = ServerError;
  const factory AuthFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AuthFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination;
}