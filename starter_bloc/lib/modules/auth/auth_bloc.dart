import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_bloc/models/user.dart';
import 'package:starter_bloc/modules/auth/auth.dart';
import 'package:starter_bloc/utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _service;

  AuthBloc(this._service) : super(AuthInitial()) {
    on<AuthStart>((event, emit) async {
      await emit.onEach(_onStart(event), onData: emit);
    });

    on<AuthRegister>((event, emit) async {
      await emit.onEach(_onRegister(event), onData: emit);
    });

    on<AuthLogin>((event, emit) async {
      await emit.onEach(_onLogin(event), onData: emit);
    });

    on<AuthLogout>((event, emit) async {
      await emit.onEach(_onLogout(event), onData: emit);
    });

    add(AuthStart());
  }

  void register(String username, String email, String password) {
    add(AuthRegister(
      username: username,
      email: email,
      password: password,
    ));
  }

  void login(String username, String password) {
    add(AuthLogin(
      username: username,
      password: password,
    ));
  }

  void logout() {
    add(AuthLogout());
  }

  Stream<AuthState> _onStart(AuthStart event) async* {
    final user = await Prefs.getString('user');
    final token = await Prefs.getString('token');

    if (user != null && token != null) {
      yield Authenticated(
        user: User.fromJson(jsonDecode(user)),
        token: token,
      );
    } else {
      yield NotAuthenticated();
    }
  }

  Stream<AuthState> _onRegister(AuthRegister event) async* {
    yield AuthLoading();

    try {
      final data = await _service.register(
        event.username,
        event.email,
        event.password,
      );

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        yield Authenticated(
          user: user,
          token: data['token'],
        );
      } else {
        yield NotAuthenticated();
      }
    } catch (e) {
      yield AuthFailed(e.toString());
    }
  }

  Stream<AuthState> _onLogin(AuthLogin event) async* {
    yield AuthLoading();

    try {
      final data = await _service.login(event.username, event.password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        yield Authenticated(
          user: user,
          token: data['token'],
        );
      } else {
        yield NotAuthenticated();
      }
    } catch (e) {
      yield AuthFailed(e.toString());
    }
  }

  Stream<AuthState> _onLogout(AuthLogout event) async* {
    yield AuthLoading();

    await Prefs.remove('user');
    await Prefs.remove('token');

    yield AuthInitial();
  }
}
