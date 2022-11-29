import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';

import '../provider/task_provider.dart';
import '../widgets/add_subtask_sheet.dart';

class DetailPage extends StatefulWidget {
  Task task;

  DetailPage({
    super.key,
    required this.task,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var getTask = Provider.of<TaskProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('detail'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 32),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'List\nYour Task',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: Colors.grey,
              ),
              ExpansionTile(
                collapsedTextColor: Colors.amber,
                textColor: Colors.amber,
                iconColor: Colors.white,
                title: Text(widget.task.taskName!),
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: getTask.tasks.data.length,
                    itemBuilder: (context, index) {
                      var result = getTask.tasks.data[index];
                      if (widget.task.id == result.parentId) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: ListTile(
                            title: Text(result.taskName!),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => AddSubTaskSheet(
              task: widget.task,
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
