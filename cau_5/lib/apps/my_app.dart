import 'package:flutter/material.dart';
import '../views/task_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 5: Delete Item',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskListView(),
    );
  }
}
