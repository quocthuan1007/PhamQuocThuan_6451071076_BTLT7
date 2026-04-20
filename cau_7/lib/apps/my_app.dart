import 'package:flutter/material.dart';
import '../views/news_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 7: Pull to Refresh',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsListView(),
    );
  }
}
