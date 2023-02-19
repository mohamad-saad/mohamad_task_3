import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mohamad_task_3/todo_list_api/services/todo_list_api_class.dart';

class Todos {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    final data = jsonDecode(response.body) as List<dynamic>;
    _todos.clear();
    _todos.addAll(data.map((e) => Todo.fromJson(e)).toList());
  }
}
