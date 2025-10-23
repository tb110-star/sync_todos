import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/notifier/home_notifier.dart';
import '../viewmodels/state/home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);

    final notifier = ref.read(homeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
      ),
      body: ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          final todo = state.todos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                todo.isDone ? Colors.green : Colors.teal,
                child: Text('${index + 1}'),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  todo.isDone
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                ),
                onPressed: () => notifier.toggleTodoStatus(todo.id),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notifier.addTodo('New Task #${state.todos.length + 1}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}