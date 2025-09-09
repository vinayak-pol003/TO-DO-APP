import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List toDo = [];
  final myBox = Hive.box("mybox");

  void createInitialData() {
    toDo = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void loadData() {
    toDo = myBox.get("TODOLIST");
  }

  void updateDatabase() {
    myBox.put("TODOLIST", toDo);
  }
}
