import 'package:starter_riverpod/data/network/api.dart';

class AuthService {
  Future register(String username, String email, String password) async {
    return await Api.register(username, email, password);
  }

  Future login(String username, String password) async {
    return await Api.login(username, password);
  }

  Future user(int id) async {
    return await Api.user(id);
  }
}
