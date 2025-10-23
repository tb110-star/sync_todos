import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/todo_item.dart';
import '../state/home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    return const HomeState();
  }

  void addTodo(String title) {
    final newTodo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
    );
    state = state.copyWith(
      todos: [...state.todos, newTodo],
    );
  }

  void toggleTodoStatus(int id) {
    final updatedList = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();

    state = state.copyWith(todos: updatedList);
  }
}

final homeNotifierProvider =
NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
