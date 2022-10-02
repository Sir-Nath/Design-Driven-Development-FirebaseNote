import 'package:notepad_firebase_ddd/core/failures.dart';

class UnExceptedValueError extends Error {
  final ValueFailure valueFailure;

  UnExceptedValueError(this.valueFailure);
  @override
  String toString() {
    return Error.safeToString(
      'Encountered a value failure at an unrecoverable point. Failure was: $valueFailure',
    );
  }
}
