import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/action_task_provider.dart';
import 'package:todo_list/provider/task_provider.dart';
import 'package:todo_list/ui/create_page.dart';
import 'package:todo_list/ui/edit_page.dart';

import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActionTaskProvider>(
          create: (_) => ActionTaskProvider(),
          child: MyHomePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        routes: {
          '/home': (context) => MyHomePage(),
          '/create': (context) => const CreatePage(),
          '/edit': (context) => EditPage(),
        },
        home: MyHomePage(),
      ),
    );
  }
}
