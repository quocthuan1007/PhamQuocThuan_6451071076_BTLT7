import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/constants.dart';

class ProductController {
  Future<Product> fetchProduct() async {
    final response = await http.get(Uri.parse('${Constants.apiUrl}/products/1'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
