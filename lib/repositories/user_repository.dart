import '../services/user_service.dart';

class UserRepository {
  final UserService service;
  UserRepository(this.service);

  Future<List<String>> getUserNames() async {
    final data = await service.fetchUsers();
    return data.map((e) => e['name'] as String).toList();
  }
}
