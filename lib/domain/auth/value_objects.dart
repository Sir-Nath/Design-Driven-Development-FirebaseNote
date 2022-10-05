import 'package:dartz/dartz.dart';
import 'package:notepad_firebase_ddd/core/value_object.dart';
import '../../core/failures.dart';
import '../../core/value_validators.dart';

//in the Auth page these are the objects i want to hold, email and password
//the value object class can accept a type of value failure and string too


class EmailAddress extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;
  const EmailAddress._(this.value);
  factory EmailAddress(String input){
    return EmailAddress._(validateEmailAddress(input));
  }
}

class Password extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;
  const Password._(this.value);
  factory Password(String input){
    return Password._(validatePassword(input));
  }
}