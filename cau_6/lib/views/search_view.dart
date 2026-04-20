import 'package:flutter/material.dart';
import '../models/product.dart';
import '../controller/search_controller.dart';
import '../widget/search_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ProductSearchController _controller = ProductSearchController();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  bool _isLoading = false;

  void _performSearch(String keyword) async {
    if (keyword.isEmpty) {
      setState(() {
        _products = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _controller.searchProducts(keyword);
      setState(() {
        _products = results;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products API')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: _performSearch,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? const Center(child: Text('No results found'))
                    : ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return SearchItem(product: _products[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
