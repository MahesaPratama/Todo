import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoModel> _todos = [];
  
  List<TodoModel> get todos {
    List<TodoModel> sortedTodos = List.from(_todos);
    sortedTodos.sort((a, b) {
      if (a.isDone == b.isDone) return 0;
      return a.isDone == false ? -1 : 1;
    });
    return sortedTodos;
  }

  void tambahTodo(String isi) {
    String id = (_todos.length + 1).toString();
    TodoModel newTodo = TodoModel(id: id, isi: isi, isDone: false);
    _todos.add(newTodo);
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isDone = !_todos[index].isDone;
      notifyListeners();
    }
  }
}
