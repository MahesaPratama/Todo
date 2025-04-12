import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todos = [];

  TodoProvider() {
    loadTodos();
  }

  // Fungsi untuk memuat data dari Shared Preferences
  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todosString = prefs.getString('todos');
    if (todosString != null) {
      List<dynamic> todosJson = json.decode(todosString);
      todos = todosJson.map((item) => TodoModel.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // Fungsi untuk menyimpan data ke Shared Preferences
  Future<void> saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> todosJson =
        todos.map((todo) => todo.toJson()).toList();
    String todosString = json.encode(todosJson);
    await prefs.setString('todos', todosString);
  }

  // Menambahkan todo baru
  void tambahTodo(String isi) {
    final newTodo = TodoModel(id: DateTime.now().toString(), isi: isi);
    todos.add(newTodo);
    saveTodos(); // simpan data setelah penambahan
    notifyListeners();
  }

  // Menghampus todo
  void hapusTodo(String id) {
  // Menghapus item dengan id tertentu dari list
  todos.removeWhere((todo) => todo.id == id);
  saveTodos(); // Simpan data yang sudah di-update ke Shared Preferences
  notifyListeners(); // Update UI
}

  // Mengubah status todo
  void toggleTodoStatus(String id) {
    int index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index].isDone = !todos[index].isDone;
      saveTodos(); // simpan data setelah perubahan status
      notifyListeners();
    }
  }
}
