import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/providers/todo_provider.dart';
import 'package:tasks_app/utils/app_colors.dart';
import 'package:tasks_app/utils/widgets/add_task_dialog.dart';
import 'package:tasks_app/utils/widgets/edit_task_dialog.dart';

import '../services/todo_services.dart';

class TodosPage extends StatelessWidget {
  TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todosProvider = context.watch<TodoProvider>();
    final todos = todosProvider.todos;

    return Scaffold(
      backgroundColor: AppColors().PrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Todos Manager',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    color: todo.completed ? Colors.green : Colors.orange,
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () => todosProvider.toggleTodoStatus(
                            todo.id, todo.completed),
                        icon: Icon(
                          todo.completed ? Icons.square : Icons.square_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        todo.todo,
                        style: TextStyle(
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : null,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        todo.completed ? 'Done' : 'Todo',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        onPressed: () => todosProvider.deleteTodo(todo.id),
                        icon: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onTap: () async {
                        final updatedTodo = await editTaskDialog(
                          context,
                          todo.id,
                          todo.todo,
                        );
                        if (updatedTodo != null) {
                          todosProvider.editTodoText(todo.id, updatedTodo);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final newTodoText = await addTaskDialog(context);
          if (newTodoText != null) {
            todosProvider.addTodo(newTodoText);
            // var todo = await TodoService().addTodo(newTodoText);
          }
        },
        backgroundColor: AppColors().SecondaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
