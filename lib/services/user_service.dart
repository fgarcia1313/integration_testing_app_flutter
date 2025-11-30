import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final http.Client client;

  UserService(this.client);

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await client.get(
      Uri.parse('https://api.miapp.com/users'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Error server: ${response.statusCode}');
    }
  }
}
