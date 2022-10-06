import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';
import 'package:notepad_firebase_ddd/core/value_validators.dart';
import '../../core/failures.dart';
import '../../core/value_object.dart';
import '../../core/value_transformer.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  const NoteBody._(this.value);
  factory NoteBody(String input) {
    return NoteBody._(
        validateMaxStringLength(input: input, maxLength: maxLength)
            .flatMap((validateStringNotEmpty)));
  }
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 30;

  const TodoName._(this.value);
  factory TodoName(String input) {
    return TodoName._(
        validateMaxStringLength(input: input, maxLength: maxLength)
            .flatMap((validateStringNotEmpty))
            .flatMap((validateSingleLine)));
  }
}

class NoteColor extends ValueObject<Color> {
  @override
  final Either<ValueFailure<Color>, Color> value;

  static const List<Color> predefinedColors = [
    Color(0xfffafafa),
    Color(0xfffa8872),
    Color(0xfffedc56),
    Color(0xffd0f0c0),
    Color(0xfffca3b7),
    Color(0xff997950),
    Color(0xfffffdd0)
  ];

  const NoteColor._(this.value);

  factory NoteColor(Color input) {
    return NoteColor._(right(makeColorOpaque(input)));
  }
}

class ListThree<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  const ListThree._(this.value);
  factory ListThree(KtList<T> input) {
    return ListThree._(
      validateMaxListLength(input, maxLength),
    );
  }

  int get length{
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull{
    return length == maxLength;
  }

}
