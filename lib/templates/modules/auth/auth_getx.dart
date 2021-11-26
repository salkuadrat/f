import 'dart:io';

/// generate template for module auth
void authGetx(String project, String dir) {
  _auth(project, dir);
  _bindings(project, dir);
  _controller(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_bindings.dart';
export 'auth_controller.dart';
export 'auth_service.dart';''');
}

void _bindings(String project, String dir) {
  File('$dir/auth_bindings.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/modules/auth/auth.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(AuthService()));
  }
}''');
}

void _controller(String project, String dir) {
  File('$dir/auth_controller.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/utils/prefs.dart';

enum AuthStatus { initial, loading, authenticated, notauthenticated, failed }

class AuthController extends GetxController {

  final AuthService _service;

  final Rx<User?> _user = Rx<User?>(null);
  final Rx<AuthStatus> _status = Rx<AuthStatus>(AuthStatus.initial);

  User? get user => _user.value;
  AuthStatus get status => _status.value;

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthController(this._service);

  Future<void> register(String username, String email, String password) async {
    _status.value = AuthStatus.loading;

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
  }

  Future<void> login(String username, String password) async {
    _status.value = AuthStatus.loading;

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
  }

  Future<void> logout() async {
    _status.value = AuthStatus.loading;

    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    _status.value = AuthStatus.initial;
    _user.value = null;
  }
}''');
}
