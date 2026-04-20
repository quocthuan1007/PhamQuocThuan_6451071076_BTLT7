import 'package:flutter/material.dart';
import '../views/user_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const UserListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
