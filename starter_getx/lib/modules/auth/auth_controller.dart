import 'package:get/get.dart';

import 'package:starter_getx/models/user.dart';
import 'package:starter_getx/modules/auth/auth.dart';
import 'package:starter_getx/utils/prefs.dart';

enum AuthStatus { initial, authenticated, notauthenticated, failed }

class AuthController extends GetxController {
  final AuthService _service;

  final Rx<User?> _user = Rx<User?>(null);
  final Rx<AuthStatus> _status = Rx<AuthStatus>(AuthStatus.initial);
  final _isLoading = false.obs;

  User? get user => _user.value;
  AuthStatus get status => _status.value;

  bool get isLoading => _isLoading.value;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthController(this._service);

  Future<void> register(String username, String email, String password) async {
    _isLoading.value = true;

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        _status.value = AuthStatus.authenticated;
        _user.value = user;
      } else {
        _status.value = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status.value = AuthStatus.failed;
    }

    _isLoading.value = false;
  }

  Future<void> login(String username, String password) async {
    _isLoading.value = true;

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        _status.value = AuthStatus.authenticated;
        _user.value = user;
      } else {
        _status.value = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status.value = AuthStatus.failed;
    }

    _isLoading.value = false;
  }

  Future<void> logout() async {
    _isLoading.value = true;

    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    _user.value = null;
    _status.value = AuthStatus.initial;
    _isLoading.value = false;
  }
}
