import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notepad_firebase_ddd/core/value_object.dart';
part 'user.freezed.dart';

@freezed
abstract class AuthUser with _$AuthUser{
  const factory AuthUser({
    required UniqueId id
}) = _AuthUser;
}

