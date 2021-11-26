import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_bloc/models/user.dart';
import 'package:starter_bloc/modules/auth/auth.dart';
import 'package:starter_bloc/utils/prefs.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _service;

  AuthBloc(this._service) : super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      await emit.onEach(_onRegister(event), onData: emit);
    });

    on<AuthLogin>((event, emit) async {
      await emit.onEach(_onLogin(event), onData: emit);
    });

    on<AuthLogout>((event, emit) async {
      await emit.onEach(_onLogout(event), onData: emit);
    });
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

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        yield Authenticated(user);
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

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        yield Authenticated(user);
      } else {
        yield NotAuthenticated();
      }
    } catch (e) {
      yield AuthFailed(e.toString());
    }
  }

  Stream<AuthState> _onLogout(AuthLogout event) async* {
    yield AuthLoading();

    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    yield AuthInitial();
  }
}
