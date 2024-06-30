import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screen.dart';
import 'package:todo_list_app/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: ToDoListScreen(),
    );
  }
}
