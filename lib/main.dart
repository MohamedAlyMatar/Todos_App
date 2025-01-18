import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/my_app.dart';
import 'package:tasks_app/providers/todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider()..fetchTodos(),
      child: const MyApp(),
    ),
  );
}
