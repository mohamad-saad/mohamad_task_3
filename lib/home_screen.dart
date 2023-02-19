import 'package:flutter/material.dart';
import 'package:mohamad_task_3/todo_list_api/todo_api_home_screen.dart';
import 'package:mohamad_task_3/todo_list_database/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: MaterialButton(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoList()));
                  },
                  child: const Text(
                    "ToDo List (DataBase)",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              MaterialButton(
                height: 50,
                padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  TodoHomeScreen()));
                },
                child: const Text(
                  "ToDo List (API)",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
