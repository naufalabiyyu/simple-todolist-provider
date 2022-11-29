import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/ui/detail_page.dart';

import '../provider/task_provider.dart';
import '../ui/edit_page.dart';
import '../data/api_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController taskController = TextEditingController(text: '');

  Future<void> getInit() async {
    await Provider.of<TaskProvider>(context, listen: false).getTask();
  }

  @override
  Widget build(BuildContext context) {
    var getTask = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoList'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getInit(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: getTask.tasks.data.length,
              itemBuilder: (context, index) {
                var result = getTask.tasks.data[index];
                List myList = getTask.tasks.data;
                if (result.parentId != null) {
                  return Container();
                }
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          ApiService().deleteTask(id: result.id);
                          setState(() {
                            myList.remove(myList[index]);
                          });
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: result.isDone,
                      activeColor: Colors.amberAccent,
                      onChanged: (value) async {
                        ApiService().doneTask(
                          id: result.id,
                          isDone: result.isDone,
                          taskName: result.taskName,
                          createdAt: result.createdAt,
                          starred: result.starred,
                        );
                        setState(() {
                          result.isDone = value!;
                        });
                      },
                    ),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(task: result),
                            ));
                      },
                      child: Text(
                        result.taskName!,
                        style: TextStyle(
                          decoration: result.isDone!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.create_rounded),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(task: result),
                            ));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
