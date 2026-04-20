import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/constants.dart';

class ProductSearchController {
  Future<List<Product>> searchProducts(String keyword) async {
    final response = await http.get(Uri.parse('${Constants.apiUrl}/products/search?q=$keyword'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
