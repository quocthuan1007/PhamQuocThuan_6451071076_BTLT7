import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../utils/constants.dart';

class PostController {
  Future<String> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return response.body; // Return server response
    } else {
      throw Exception('Failed to create post.');
    }
  }
}
