import 'dart:io';

/// generate template for module auth
void authProvider(String project, String dir) {
  _auth(project, dir);
  _state(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_state.dart';
export 'auth_service.dart';''');
}

void _state(String project, String dir) {
  File('$dir/auth_state.dart').writeAsStringSync('''
import 'package:flutter/foundation.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/utils/prefs.dart';

enum AuthEvent { register, login, logout }
enum AuthStatus { initial, authenticated, notauthenticated, failed }

class AuthState extends ChangeNotifier {

  final AuthService _service;

  User? _user;
  AuthEvent? _event;
  AuthStatus _status = AuthStatus.initial;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  AuthEvent? get event => _event;
  AuthStatus get status => _status;
  String get error => _error;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get notAuthenticated => _status == AuthStatus.notauthenticated;
  bool get isFailed => _status == AuthStatus.failed;

  AuthState(this._service) {
    _event = null;
    _status = AuthStatus.initial;
    _isLoading = false;
    _error = '';
  }

  Future register(String username, String email, String password) async {
    _event = AuthEvent.register;
    _isLoading = true;

    notifyListeners();

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        _user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.failed;
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future login(String username, String password) async {
    _event = AuthEvent.login;
    _isLoading = true;

    notifyListeners();

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        _user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status = AuthStatus.failed;
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future logout() async {
    _event = AuthEvent.logout;
    _isLoading = true;

    notifyListeners();
    
    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    _status = AuthStatus.initial;
    _error = '';
    _event = null;
    _isLoading = false;

    notifyListeners();
  }
}''');
}
