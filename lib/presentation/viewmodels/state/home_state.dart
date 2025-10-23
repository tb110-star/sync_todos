import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/todo_item.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<TodoItem> todos,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _HomeState;
}
