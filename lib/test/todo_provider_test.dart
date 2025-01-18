// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tasks_app/models/todo_model.dart';
// import 'package:tasks_app/providers/todo_provider.dart';
// import 'package:tasks_app/services/todo_services.dart';
// import 'todo_service_test.mocks.dart';

// void main() {
//   late TodoProvider todoProvider;
//   late MockTodoService mockTodoService;

//   setUp(() {
//     mockTodoService = MockTodoService();
//     todoProvider = TodoProvider();
//     todoProvider.fetchTodos();
//   });

//   group('TodoProvider Tests', () {
//     test('fetchTodos populates the todo list', () async {
//       // Arrange
//       final mockTodos = [
//         TodoModel(id: 1, todo: 'Test Todo 1', completed: false, userId: 100),
//         TodoModel(id: 2, todo: 'Test Todo 2', completed: true, userId: 200),
//       ];
//       when(mockTodoService.getTodos()).thenAnswer((_) async => mockTodos);

//       // Act
//       await todoProvider.fetchTodos();

//       // Assert
//       expect(todoProvider.todos, mockTodos);
//     });

//     test('toggleTodoStatus updates todo status', () async {
//       // Arrange
//       final todo =
//           TodoModel(id: 1, todo: 'Test Todo', completed: false, userId: 100);
//       todoProvider.todos.add(todo);

//       // Act
//       await todoProvider.toggleTodoStatus(todo.id, todo.completed);

//       // Assert
//       expect(todo.completed, true);
//     });

//     test('deleteTodo removes a todo', () async {
//       // Arrange
//       final todo =
//           TodoModel(id: 1, todo: 'Test Todo', completed: false, userId: 100);
//       todoProvider.todos.add(todo);

//       // Act
//       await todoProvider.deleteTodo(todo.id);

//       // Assert
//       expect(todoProvider.todos, isEmpty);
//     });

//     test('addTodo adds a new todo', () async {
//       // Arrange
//       const newTodoText = 'New Todo';
//       final newTodo =
//           TodoModel(id: 1, todo: newTodoText, completed: false, userId: 100);
//       when(mockTodoService.addTodo(newTodoText))
//           .thenAnswer((_) async => newTodo);

//       // Act
//       await todoProvider.addTodo(newTodo);

//       // Assert
//       expect(todoProvider.todos.length, 1);
//       expect(todoProvider.todos.first.todo, newTodoText);
//     });
//   });
// }
