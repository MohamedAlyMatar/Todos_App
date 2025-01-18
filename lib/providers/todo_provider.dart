import 'package:flutter/material.dart';
import 'package:tasks_app/models/todo_model.dart';
import 'package:tasks_app/services/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  final TodoService _todoService = TodoService();

  List<TodoModel> get todos => _todos;

  Future<void> fetchTodos() async {
    _todos = await _todoService.getTodos();
    notifyListeners();
  }

  void toggleTodoStatus(int todoId, bool isCompleted) {
    _todoService.toggleTodo(todoId, isCompleted);
    final todo = _todos.firstWhere((todo) => todo.id == todoId);
    todo.completed = !todo.completed;
    notifyListeners();
  }

  void deleteTodo(int todoId) {
    _todoService.deleteTodo(todoId);
    _todos.removeWhere((todo) => todo.id == todoId);
    notifyListeners();
  }

  void editTodoText(int todoId, String newText) {
    _todoService.editTodo(todoId, newText);
    final todo = _todos.firstWhere((todo) => todo.id == todoId);
    todo.todo = newText;
    notifyListeners();
  }

  Future<void> addTodo(TodoModel newTodo) async {
    // final newTodo = await _todoService.addTodo(newTodoText);
    if (newTodo != null) {
      _todos.add(newTodo);
      notifyListeners();
    }
  }
}
