import 'package:flutter/material.dart';
import 'package:tasks_app/services/todo_services.dart';
import 'package:tasks_app/utils/app_colors.dart';

Future<String?> editTaskDialog(
    BuildContext context, int todoId, String initialTodo) async {
  final TextEditingController textController =
      TextEditingController(text: initialTodo);

  String? updatedTodo = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors().DialogColor,
        title: Text(
          'Edit Task',
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
            onPressed: () {
              TodoService().editTodo(todoId, textController.text);
              // Navigator.pop(context, null);
              Navigator.pop(context, textController.text);
            },
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      );
    },
  );

  // textController.dispose();
  return updatedTodo;
}
