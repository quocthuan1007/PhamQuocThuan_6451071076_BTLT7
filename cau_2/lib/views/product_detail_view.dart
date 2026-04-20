import 'package:flutter/material.dart';
import '../models/product.dart';
import '../controller/product_controller.dart';
import '../widget/custom_text.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductController _controller = ProductController();
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = _controller.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: Center(
        child: FutureBuilder<Product>(
          future: _futureProduct,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red));
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    CustomText(text: product.description),
                  ],
                ),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
