import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String usersEndpoint = '/users';

  /// Fetch list of users from API
  /// Returns List<User> on success
  /// Throws Exception on failure
  static Future<List<User>> fetchUsers() async {
    try {
      final url = Uri.parse('$baseUrl$usersEndpoint');
      print('Fetching from: $url');
      
      final response = await http.get(url).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('Request timeout');
          throw Exception('Request timeout after 15 seconds');
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body length: ${response.body.length}');

      if (response.statusCode == 200) {
        // Parse JSON response - jsonplaceholder returns array directly
        final List<dynamic> jsonList = jsonDecode(response.body);
        print('Parsed ${jsonList.length} users');
        
        // Convert JSON list to User list
        final List<User> users = jsonList
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
        
        print('Successfully converted ${users.length} users');
        return users;
      } else {
        throw Exception(
          'Failed to load users. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching users: $e');
    }
  }
}
