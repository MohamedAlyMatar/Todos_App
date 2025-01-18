import 'package:flutter/material.dart';
import 'package:tasks_app/models/todo_model.dart';
import 'package:tasks_app/services/todo_services.dart';

import '../app_colors.dart';

Future<TodoModel?> addTaskDialog(BuildContext context) async {
  final TextEditingController textController = TextEditingController();

  TodoModel? newTodo = await showDialog<TodoModel>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: AppColors().DialogColor,
          title: Text(
            'Add Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: TextField(
            maxLines: 2,
            controller: textController,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors().PrimaryColor),
              ),
              onPressed: () async {
                var todo = await TodoService().addTodo(textController.text);
                var newTodo = createTodoModel(textController.text);
                Navigator.pop(context, newTodo);
              },
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ]);
    },
  );

  // textController.dispose();
  return newTodo;
}
