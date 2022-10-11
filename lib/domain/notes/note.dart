import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:notepad_firebase_ddd/core/value_object.dart';
import 'package:notepad_firebase_ddd/domain/notes/todo_item.dart';
import 'package:notepad_firebase_ddd/domain/notes/value_objects.dart';
part 'note.freezed.dart';

//each note should have the following parameters

@freezed
abstract class Note with _$Note {
  //the abstract class of note should contain the following parameters
  const factory Note(
      {required UniqueId id,
      required NoteBody body,
      required NoteColor color,
      required ListThree<TodoItem> todos}) = _Note;
  //the default / empty state of a note entity should be this
  factory Note.empty() => Note(
        id: UniqueId(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors[0]),
        todos: ListThree(
          emptyList(),
        ),
      );

}
