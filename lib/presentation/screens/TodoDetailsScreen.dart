import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/notifier/home_notifier.dart';

class TodoDetailsScreen extends ConsumerWidget {
  const TodoDetailsScreen({super.key, required this.todoId});
  final int todoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);
    final todo = state.todos.firstWhere((t) => t.id == todoId);

    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}
