import 'package:flutter/material.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  ToDoDatabase database = ToDoDatabase();

  @override
  void initState() {
    super.initState();
    database.loadData();
    if (database.todoList.isEmpty) {
      database.createInitialData();
      database.updateData();
    }
  }

  // checkbox onChanged function
  void checkboxChange(bool? value, int index) {
    setState(() {
      database.todoList[index][1] = value!;
    });
    database.updateData();
  }

  void onSaved() {
    setState(() {
      database.todoList.add([
        _controller.text,
        false
      ]);
      _controller.clear();
      Navigator.pop(context);
    });
    database.updateData();
  }

  // create new task function
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSaved: onSaved,
          onCancel: () {
            _controller.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // delete task function
  deleteTask(int index) {
    // confirm before deleting
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this task?', style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  database.todoList.removeAt(index);
                  database.updateData();
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.deepPurple[200],
          child: const Icon(Icons.add),
        ),
      ),
      body: database.todoList.isEmpty
          ? const Center(
              child: Text(
                'No Tasks Available!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
            )
          : ListView.builder(
              itemCount: database.todoList.length,
              itemBuilder: (context, index) {
                String taskName = database.todoList[index][0];
                bool isCompleted = database.todoList[index][1];
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? 20.0 : 15.0,
                    left: 25.0,
                    right: 25.0,
                  ),
                  child: ToDoTile(
                    onDeleteTask: (context) => deleteTask(index),
                    taskName: taskName,
                    isCompleted: isCompleted,
                    onChanged: (value) {
                      checkboxChange(value, index);
                    },
                  ),
                );
              },
            ),
    );
  }
}
