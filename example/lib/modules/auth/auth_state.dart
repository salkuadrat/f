import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:example/models/user.dart';
import 'package:example/modules/auth/auth.dart';
import 'package:example/utils/utils.dart';

enum AuthEvent { register, login, logout }
enum AuthStatus { initial, authenticated, notauthenticated, failed }

class AuthState extends ChangeNotifier {
  final AuthService _service;

  User? _user;
  AuthEvent? _event;
  AuthStatus _status = AuthStatus.initial;
  bool _isLoading = false;
  String? _token;
  String _error = '';

  User? get user => _user;
  AuthEvent? get event => _event;
  AuthStatus get status => _status;
  String? get token => _token;
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

  Future init() async {
    final user = await Prefs.getString('user');
    final token = await Prefs.getString('token');

    if (user != null) {
      _user = User.fromJson(jsonDecode(user));
    }

    if (token != null) {
      _token = token;
    }

    if (_user != null && _token != null) {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.notauthenticated;
    }

    notifyListeners();
  }

  Future register(String username, String email, String password) async {
    _event = AuthEvent.register;
    _isLoading = true;

    notifyListeners();

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        _user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user!.toJson()));
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

        await Prefs.setString('user', jsonEncode(user!.toJson()));
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

    await Prefs.remove('user');
    await Prefs.remove('token');

    _status = AuthStatus.initial;
    _error = '';
    _event = null;
    _user = null;
    _token = null;
    _isLoading = false;

    notifyListeners();
  }
}
