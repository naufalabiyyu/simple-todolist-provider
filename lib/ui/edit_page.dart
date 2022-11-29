import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/action_task_provider.dart';
import '../models/task.dart';
import './home_page.dart';

class EditPage extends StatelessWidget {
  Task? task;

  EditPage({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController =
        TextEditingController(text: task!.taskName);
    ActionTaskProvider editTask = Provider.of<ActionTaskProvider>(context);

    submitTask() async {
      if (await editTask.editTask(
        id: task!.id,
        taskName: taskController.text,
        isDone: task!.isDone,
        starred: task!.starred,
        createdAt: task!.createdAt,
      )) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MyHomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'Task successfully edited!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {}
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Edit\nYour Task',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  controller: taskController,
                  autocorrect: false,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "What would you like to do?",
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(top: 40),
                child: TextButton(
                  onPressed: submitTask,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Kirim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
