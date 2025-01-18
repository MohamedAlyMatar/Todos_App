import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/models/todo_model.dart';

class TodoService {
  final String todosEndpoint = "https://dummyjson.com/todos";

  int _skip = 0;
  final int _limit = 10;
  static const String storageKey = 'todos';
  bool isLoading = false;

  Future<List<TodoModel>> getTodos() async {
    if (isLoading) return [];
    isLoading = true;
    List<TodoModel> newTodos = [];

    try {
      String endpoint = "https://dummyjson.com/todos?limit=$_limit&skip=$_skip";
      var response = await Dio().get(endpoint);
      print("API Response: ${response.data}");

      var data = response.data['todos'];
      data.forEach((todo) => newTodos.add(TodoModel.fromJson(todo)));

      _skip += _limit;

      // todos = data.map<TodoModel>((todo) => TodoModel.fromJson(todo)).toList();
      // List<TodoModel> newTodos =
      //     data.map<TodoModel>((todo) => TodoModel.fromJson(todo)).toList();
    } catch (e) {
      print("Error fetching todos: ${e.toString()}");
      newTodos = await fetchTodosLocally();
    } finally {
      isLoading = false;
    }
    return newTodos;
  }

  // Future<List<TodoModel>> getTodos() async {
  //   List<TodoModel> todos = [];
  //   try {
  //     var response = await Dio().get(todosEndpoint);
  //     var data = response.data['todos'];
  //     data.forEach((todo) => todos.add(TodoModel.fromJson(todo)));
  //     // todos = data.map<TodoModel>((todo) => TodoModel.fromJson(todo)).toList();
  //     await saveTodosLocally(todos);
  //   } catch (e) {
  //     print("Error fetching todos from API: ${e.toString()}");
  //     todos = await fetchTodosLocally();
  //   }
  //   return todos;
  // }

  Future<void> saveTodosLocally(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(storageKey, todosString);
  }

  Future<List<TodoModel>> fetchTodosLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString(storageKey);
    if (todosString != null) {
      final List<dynamic> decodedData = jsonDecode(todosString);
      return decodedData
          .map<TodoModel>((item) => TodoModel.fromJson(item))
          .toList();
    }
    return [];
  }

  Future<void> editTodoLocally(int todoId, String newTodo) async {
    final todos = await fetchTodosLocally();
    final todo = todos.firstWhere((todo) => todo.id == todoId);
    todo.todo = newTodo;
    await saveTodosLocally(todos);
  }

  Future<void> toggleTodoLocally(int todoId, bool isCompleted) async {
    final todos = await fetchTodosLocally();
    final todo = todos.firstWhere((todo) => todo.id == todoId);
    todo.completed = !isCompleted;
    await saveTodosLocally(todos);
  }

  Future<void> deleteTodoLocally(int todoId) async {
    final todos = await fetchTodosLocally();
    todos.removeWhere((todo) => todo.id == todoId);
    await saveTodosLocally(todos);
  }

  Future<void> addTodoLocally(TodoModel newTodo) async {
    final todos = await fetchTodosLocally();
    todos.add(newTodo);
    await saveTodosLocally(todos);
  }

  void editTodo(int todoId, String newTodo) async {
    try {
      var response =
          await Dio().put("$todosEndpoint/$todoId", data: {"todo": newTodo});
      print("TODO EDITED: ${response.data}");
    } catch (e) {
      print("Error editing todo: ${e.toString()}");
    }
    await editTodoLocally(todoId, newTodo); // Update locally
  }

  void toggleTodo(int todoId, bool isCompleted) async {
    try {
      var response = await Dio()
          .put("$todosEndpoint/$todoId", data: {"completed": !isCompleted});
      print("TODO TOGGLED: ${response.data}");
    } catch (e) {
      print("Error toggling todo: ${e.toString()}");
    }
    await toggleTodoLocally(todoId, isCompleted); // Update locally
  }

  Future<TodoModel?> addTodo(String todoText) async {
    TodoModel? todo;
    try {
      var response = await Dio().post("$todosEndpoint/add", data: {
        "todo": todoText,
        "completed": false,
        "userId": 001,
      });
      print("TODO Posted: ${response.data}");
      todo = TodoModel.fromJson(response.data);
    } catch (e) {
      print("Error posting todo: ${e.toString()}");
    }
    if (todo != null) {
      await addTodoLocally(todo); // Save locally
    }
    return todo;
  }

  void deleteTodo(int todoId) async {
    try {
      var response = await Dio().delete("$todosEndpoint/$todoId");
      print("TODO Deleted: ${response.data}");
    } catch (e) {
      print("Error deleting todo: ${e.toString()}");
    }
    await deleteTodoLocally(todoId); // Remove locally
  }
}
