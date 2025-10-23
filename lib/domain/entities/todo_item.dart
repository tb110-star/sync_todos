
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_item.freezed.dart';@freezed

sealed class TodoItem with _$TodoItem {
  const factory TodoItem({
    required int id,
    required String title,
    @Default(false) bool isDone,
    @Default('') String description,
  }) = _TodoItem;
}
