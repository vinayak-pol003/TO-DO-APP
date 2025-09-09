import 'package:counterapp/data/database.dart';
import 'package:counterapp/utils/dailog_box.dart';
import 'package:counterapp/utils/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box("mybox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    // TODO: implement initState

    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final textcontroller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDo[index][1] = !db.toDo[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    if (textcontroller.text.trim().isNotEmpty) {
      setState(() {
        db.toDo.add([textcontroller.text.trim(), false]);
        textcontroller.clear(); // Clear the text field
      });
      Navigator.pop(context);
      db.updateDatabase();
    }
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          contoller: textcontroller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void taskDelete(int index) {
    setState(() {
      db.toDo.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("T O  D O"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: db.toDo.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDo[index][0],
            taskCompleted: db.toDo[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => taskDelete(index),
          );
        },
      ),
    );
  }
}
