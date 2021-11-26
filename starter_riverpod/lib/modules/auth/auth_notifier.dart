import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:starter_riverpod/models/user.dart';
import 'package:starter_riverpod/modules/auth/auth.dart';
import 'package:starter_riverpod/utils/prefs.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(AuthInitial());

  Future<void> register(String username, String email, String password) async {
    state = AuthLoading();

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        state = Authenticated(user);
      } else {
        state = NotAuthenticated();
      }
    } catch (e) {
      state = AuthFailed(e.toString());
    }
  }

  Future<void> login(String username, String password) async {
    state = AuthLoading();

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        state = Authenticated(user);
      } else {
        state = NotAuthenticated();
      }
    } catch (e) {
      state = AuthFailed(e.toString());
    }
  }

  Future<void> logout() async {
    state = AuthLoading();

    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    state = AuthInitial();
  }

  @override
  void dispose() {
    state = AuthInitial();
    super.dispose();
  }
}
