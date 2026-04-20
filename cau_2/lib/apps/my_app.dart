import 'package:flutter/material.dart';
import '../views/product_detail_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 2: Product Detail',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductDetailView(),
    );
  }
}
