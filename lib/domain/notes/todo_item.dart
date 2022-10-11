import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notepad_firebase_ddd/core/value_object.dart';
import 'package:notepad_firebase_ddd/domain/notes/value_objects.dart';
part 'todo_item.freezed.dart';

//each to do item should have the following parameters.
@freezed
abstract class TodoItem with _$TodoItem {

  const factory TodoItem(
      {required UniqueId id,
      required TodoName name,
      required bool done}) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );

}
