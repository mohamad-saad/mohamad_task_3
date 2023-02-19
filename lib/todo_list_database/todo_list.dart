import 'package:flutter/material.dart';
import 'package:mohamad_task_3/todo_list_database/dbhelper.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final todoController = TextEditingController();
  // final todoEditedController = TextEditingController();

  bool validated = true;
  String errorMessage = "";
  String todoAdded = "";
  String todoEdited = "";
  var myTodos = [];
  int todoID = 0;
  List<Widget> listOfCards = [];
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return const Center(
            child: Text("NO Data"),
          );
        } else {
          if (myTodos.length == 0) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("My Tasks"),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: showAlertDialog,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
              body: const Center(
                child: Text(
                  "No Tasks Available",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Todo List DataBase"),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: showAlertDialog,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: listOfCards,
                  ),
                ));
          }
        }
      },
      future: query(),
    );
  }

  void showAlertDialog() {
    todoController.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Task"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: todoController,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorMessage,
                    ),
                    onChanged: (value) {
                      todoAdded = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (todoController.text.isEmpty) {
                          setState(() {
                            errorMessage = " Cannot be empty";
                            validated = false;
                          });
                        } else if (todoController.text.length > 100) {
                          setState(() {
                            errorMessage = " Too Many Characters";
                            validated = false;
                          });
                        } else {
                          addTodo();
                        }
                      })
                ],
              ),
            );
          });
        });
  }

  void showEditAlertDialog(Map<String, dynamic> task) {
    todoController.text = task['todo'];
    todoEdited = todoController.text;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Task"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: todoController,
                    style: const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorMessage,
                    ),
                    onChanged: (value) {
                      todoEdited = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (todoController.text.isEmpty) {
                          setState(() {
                            errorMessage = " Cannot be empty";
                            validated = false;
                          });
                        } else if (todoController.text.length > 100) {
                          setState(() {
                            errorMessage = " Too Many Characters";
                            validated = false;
                          });
                        } else {
                          editTodo();
                        }
                      })
                ],
              ),
            );
          });
        });
  }

  void addTodo() async {
    Map<String, dynamic> todo = {
      DatabaseHelper.columnName: todoAdded,
    };
    await dbHelper.insert(todo);
    Navigator.of(context, rootNavigator: true).pop();
    todoAdded = "";
    setState(() {
      validated = true;
      errorMessage = "";
    });
  }

  Future<bool> query() async {
    myTodos = [];
    listOfCards = [];
    var listOfAllTodos = await dbHelper.queryAllTodos();
    listOfAllTodos?.forEach((task) {
      myTodos.add(task.toString());
      listOfCards.add(
        Card(
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(
                task['todo'],
                style: const TextStyle(fontSize: 18.0),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      dbHelper.deleteTodo(task['id']);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showEditAlertDialog(task);
                      setState(() {
                        todoID = task[DatabaseHelper.columnId];
                        print(todoID);
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
    return Future.value(true);
  }

  void editTodo() async {
    Map<String, dynamic> updatedTodo = {
      DatabaseHelper.columnId: todoID,
      DatabaseHelper.columnName: todoEdited,
    };
    await dbHelper.updateTodo(updatedTodo);
    Navigator.of(context, rootNavigator: true).pop();
    todoEdited = "";
    setState(() {
      validated = true;
      errorMessage = "";
    });
  }
}
