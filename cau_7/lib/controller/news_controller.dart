import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';
import '../utils/constants.dart';

class NewsController {
  Future<List<News>> getNews() async {
    // Simulate network delay to show the refresh animation clearly
    await Future.delayed(const Duration(seconds: 1));
    
    final response = await http.get(Uri.parse('${Constants.apiUrl}/posts?_limit=10'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<News> newsList = data.map((json) => News.fromJson(json)).toList();
      newsList.shuffle(); // Shuffle to show data changes on refresh
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
