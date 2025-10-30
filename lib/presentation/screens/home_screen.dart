import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/notifier/home_notifier.dart';
import '../viewmodels/state/home_state.dart';
import '../widgets/glass.dart';
import 'package:go_router/go_router.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider);
    final notifier = ref.read(homeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          final todo = state.todos[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              onTap: () => context.push('/todo/${todo.id}'),
              leading: CircleAvatar(
                backgroundColor: todo.isDone ? Colors.green : Colors.orange.shade400,
                child: Text('${index + 1}'),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: todo.description.isNotEmpty
                  ? Text(
                todo.description,
                style: const TextStyle(color: Colors.black54),
              )
                  : null,
              trailing: IconButton(
                icon: Icon(
                  todo.isDone
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: todo.isDone ? Colors.green : Colors.grey,
                ),
                onPressed: () => notifier.toggleTodoStatus(todo.id),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Todo', style: TextStyle(color: Colors.white)),
        onPressed: () async {
          final titleController = TextEditingController();
          final descController = TextEditingController();

          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black38,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  left: 16,
                  right: 16,
                ),
                child: Glass(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Text(
                          'Add New Todo',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          prefixIcon: const Icon(Icons.title_rounded, color: Colors.blueAccent),
                          filled: true,
                          fillColor: Colors.blueAccent.withAlpha(25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(color: Colors.blueAccent.withOpacity(0.7), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextField(
                        controller: descController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          prefixIcon: const Icon(Icons.description_rounded,
                              color: Colors.blueAccent),
                          filled: true,
                          fillColor: Colors.blueAccent.withAlpha(25),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(color: Colors.blueAccent.withOpacity(0.7), width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blueAccent.shade700,
                              backgroundColor: Colors.blueAccent.withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 10),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueAccent.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),

                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            onPressed: () {
                              final title = titleController.text.trim();
                              final desc = descController.text.trim();
                              if (title.isNotEmpty) {
                                notifier.addTodo(title, description: desc);
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.save, size: 18),
                            label: const Text('Add'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
