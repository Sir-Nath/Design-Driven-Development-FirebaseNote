import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'error.dart';
import 'failures.dart';

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
