import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import '../utils/constants.dart';

class TaskController {
  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('${Constants.apiUrl}/todos?_limit=10'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<bool> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('${Constants.apiUrl}/todos/$id'));
    return response.statusCode == 200;
  }
}
