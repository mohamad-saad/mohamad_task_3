import 'package:flutter/material.dart';
import 'services/api_fetch.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({Key? key}) : super(key: key);

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final _todos = Todos();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    setState(() {
      _isLoading = true;
    });

    await _todos.fetchTodos();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Class C',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _todos.todos.length,
        itemBuilder: (context, index) {
          final todo = _todos.todos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  todo.title,
                  style:
                  const TextStyle(fontSize: 26, color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
                      value: todo.completed,
                      onChanged: null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
