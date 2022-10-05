import 'package:dartz/dartz.dart';
import 'failures.dart';


//value validator return a value failure or a String based on an input and a validation carried on it

Either<ValueFailure<String>, String> validateEmailAddress(String input){
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if(RegExp(emailRegex).hasMatch(input)){
    return right(input);
  }else{
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input){
  if(input.length >= 6){
    return right(input);
  }else{
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}
