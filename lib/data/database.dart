import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];
  final _myBox = Hive.box("tasks");

  void createInitialData() {
    todoList = [
      [
        "Buy Groceries",
        false
      ],
      [
        "Pay Bills",
        false
      ],
      [
        "Go to the Gym",
        false
      ],
      [
        "Read a Book",
        false
      ],
      [
        "Call Mom",
        false
      ],
    ];
  }

  void loadData() {
    todoList = _myBox.get("tasks", defaultValue: todoList);
  }

  void updateData() {
    _myBox.put("tasks", todoList);
  }
}
