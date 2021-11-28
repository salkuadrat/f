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
import 'dart:convert';

import 'package:get/get.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/utils/utils.dart';

enum AuthStatus { initial, authenticated, notauthenticated, failed }

class AuthController extends GetxController {
  final AuthService _service;

  final Rx<User?> _user = Rx<User?>(null);
  final Rx<String?> _token = Rx<String?>(null);
  final Rx<AuthStatus> _status = Rx<AuthStatus>(AuthStatus.initial);
  final _isLoading = false.obs;

  User? get user => _user.value;
  String? get token => _token.value;
  AuthStatus get status => _status.value;

  bool get isLoading => _isLoading.value;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthController(this._service);

  Future init() async {
    final user = await Prefs.getString('user');
    final token = await Prefs.getString('token');

    if (user != null && token != null) {
      _status.value = AuthStatus.authenticated;
      _user.value = User.fromJson(jsonDecode(user));
      _token.value = token;
    } else {
      _status.value = AuthStatus.notauthenticated;
    }
  }

  Future register(String username, String email, String password) async {
    _isLoading.value = true;

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        _status.value = AuthStatus.authenticated;
        _token.value = data['token'];
        _user.value = user;
      } else {
        _status.value = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status.value = AuthStatus.failed;
    }

    _isLoading.value = false;
  }

  Future login(String username, String password) async {
    _isLoading.value = true;

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        _status.value = AuthStatus.authenticated;
        _token.value = data['token'];
        _user.value = user;
      } else {
        _status.value = AuthStatus.notauthenticated;
      }
    } catch (e) {
      _status.value = AuthStatus.failed;
    }

    _isLoading.value = false;
  }

  Future logout() async {
    _isLoading.value = true;

    await Prefs.remove('user');
    await Prefs.remove('token');

    _user.value = null;
    _status.value = AuthStatus.initial;
    _isLoading.value = false;
  }
}''');
}
