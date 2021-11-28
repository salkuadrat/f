import 'dart:io';

/// generate template for module auth
void authRiverpod(String project, String dir) {
  _auth(project, dir);
  _notifier(project, dir);
  _provider(project, dir);
  _state(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_notifier.dart';
export 'auth_provider.dart';
export 'auth_state.dart';
export 'auth_service.dart';''');
}

void _notifier(String project, String dir) {
  File('$dir/auth_notifier.dart').writeAsStringSync('''
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/utils/utils.dart';

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
}''');
}

void _provider(String project, String dir) {
  File('$dir/auth_provider.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/auth/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthService()),
);''');
}

void _state(String project, String dir) {
  File('$dir/auth_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';
import 'package:$project/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  final String token;

  const Authenticated({
    required this.user,
    required this.token,
  });

  @override
  List<Object> get props => [user, token];
}

class NotAuthenticated extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [message];
}''');
}
