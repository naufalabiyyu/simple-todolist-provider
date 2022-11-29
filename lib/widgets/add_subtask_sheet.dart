import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ui/home_page.dart';

import '../models/task.dart';
import '../provider/action_task_provider.dart';

class AddSubTaskSheet extends StatefulWidget {
  Task task;

  AddSubTaskSheet({
    super.key,
    required this.task,
  });

  @override
  State<AddSubTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddSubTaskSheet> {
  @override
  Widget build(BuildContext context) {
    ActionTaskProvider addTask = Provider.of<ActionTaskProvider>(context);
    TextEditingController taskController = TextEditingController(text: '');

    submitTask() async {
      if (await addTask.addNewTask(
        parentId: widget.task.id,
        taskName: taskController.text,
        startDate: null,
        dueDate: null,
      )) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MyHomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'New subtask successfully added!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {}
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 300,
        child: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.5,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('Add SubTask'),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Divider(
                    color: Colors.grey,
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
                        'Send',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
