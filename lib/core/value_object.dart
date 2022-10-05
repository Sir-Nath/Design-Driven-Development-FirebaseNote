import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'error.dart';
import 'failures.dart';

//this is the contract that all value object should hold

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    return value.fold(
      (f) => throw UnExceptedValueError(f),
      (r) => r,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Value($value)';
  }
}

class UniqueId extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;
  const UniqueId._(this.value);
  factory UniqueId(){
    return UniqueId._(
      right(const Uuid().v1())
    );
  }
    factory UniqueId.fromUniqueString(String uniqueId){
      return UniqueId._(
        right(uniqueId)
      );
  }
}