import 'package:flutter/material.dart';
import '../models/product.dart';

class SearchItem extends StatelessWidget {
  final Product product;

  const SearchItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text('\$${product.price}'),
    );
  }
}
