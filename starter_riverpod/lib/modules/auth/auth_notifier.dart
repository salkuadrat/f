import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:starter_riverpod/models/user.dart';
import 'package:starter_riverpod/modules/auth/auth.dart';
import 'package:starter_riverpod/utils/utils.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(AuthInitial()) {
    init();
  }

  Future init() async {
    final user = await Prefs.getString('user');
    final token = await Prefs.getString('token');

    if (user != null && token != null) {
      state = Authenticated(
        user: User.fromJson(jsonDecode(user)),
        token: token,
      );
    } else {
      state = NotAuthenticated();
    }
  }

  Future register(String username, String email, String password) async {
    state = AuthLoading();

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        state = Authenticated(
          user: user,
          token: data['token'],
        );
      } else {
        state = NotAuthenticated();
      }
    } catch (e) {
      state = AuthFailed(e.toString());
    }
  }

  Future login(String username, String password) async {
    state = AuthLoading();

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        state = Authenticated(
          user: user,
          token: data['token'],
        );
      } else {
        state = NotAuthenticated();
      }
    } catch (e) {
      state = AuthFailed(e.toString());
    }
  }

  Future logout() async {
    state = AuthLoading();

    await Prefs.remove('user');
    await Prefs.remove('token');

    state = AuthInitial();
  }

  @override
  void dispose() {
    state = AuthInitial();
    super.dispose();
  }
}
