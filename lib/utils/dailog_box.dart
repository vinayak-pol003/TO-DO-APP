import 'package:counterapp/utils/my_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DailogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final contoller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DailogBox({
    super.key,
    required this.contoller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 130,
        width: 300,
        child: Column(
          children: [
            TextField(
              controller: contoller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: "Add a new task..",
              ),
            ),

            Row(
              children: [
                Padding(padding: EdgeInsets.all(35)),
                MyButton(text: "Save", onPressed: onSave),
                SizedBox(width: 30),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
