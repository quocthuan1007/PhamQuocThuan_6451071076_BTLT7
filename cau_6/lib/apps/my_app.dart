import 'package:flutter/material.dart';
import '../views/search_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 6: Search API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SearchView(),
    );
  }
}
