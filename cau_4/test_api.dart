import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    var r1 = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    print('cau_1 test: ${r1.statusCode}');
  } catch(e) { print('cau_1 err: $e'); }

  try {
    var r4 = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    print('cau_4 test: ${r4.statusCode}');
  } catch(e) { print('cau_4 err: $e'); }

  try {
    var r5 = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    print('cau_5 test: ${r5.statusCode}');
  } catch(e) { print('cau_5 err: $e'); }

  try {
    var r7 = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));
    print('cau_7 test: ${r7.statusCode}');
  } catch(e) { print('cau_7 err: $e'); }
}
