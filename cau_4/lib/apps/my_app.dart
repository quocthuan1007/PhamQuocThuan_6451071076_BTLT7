import 'package:flutter/material.dart';
import '../views/update_user_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 4: Update User Info',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UpdateUserView(),
    );
  }
}
