import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    var r1 = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'), headers: {'User-Agent': 'Mozilla/5.0'});
    print('cau_1 test: ${r1.statusCode}');
  } catch(e) { print('cau_1 err: $e'); }
}
