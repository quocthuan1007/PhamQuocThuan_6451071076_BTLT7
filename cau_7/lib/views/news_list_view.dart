import 'package:flutter/material.dart';
import '../models/news.dart';
import '../controller/news_controller.dart';
import '../widget/news_item.dart';

class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  final NewsController _controller = NewsController();
  List<News> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    try {
      final news = await _controller.getNews();
      setState(() {
        _newsList = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading news: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News List (Pull to Refresh)')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNews,
              child: ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  return NewsItem(news: _newsList[index]);
                },
              ),
            ),
    );
  }
}
