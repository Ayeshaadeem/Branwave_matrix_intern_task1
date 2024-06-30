import 'package:flutter/material.dart';
import 'package:todo_list_app/model.dart';
import 'package:uuid/uuid.dart';

class ToDoProvider with ChangeNotifier {
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;

  void addTask(String task) {
    final newTodo = ToDo(
      id: Uuid().v4(),
      task: task,
    );
    _todos.add(newTodo);
    notifyListeners();
  }

  void editTask(String id, String newTask) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].task = newTask;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      notifyListeners();
    }
  }
}
