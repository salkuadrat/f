import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_cubit/models/user.dart';
import 'package:starter_cubit/utils/utils.dart';

import 'auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service;

  AuthCubit(this._service) : super(AuthInitial());

  Future init() async {
    final user = await Prefs.getString('user');
    final token = await Prefs.getString('token');

    if (user != null && token != null) {
      emit(Authenticated(
        user: User.fromJson(jsonDecode(user)),
        token: token,
      ));
    } else {
      emit(NotAuthenticated());
    }
  }

  Future register(String username, String email, String password) async {
    emit(AuthLoading());

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        emit(Authenticated(
          user: user,
          token: data['token'],
        ));
      } else {
        emit(NotAuthenticated());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future login(String username, String password) async {
    emit(AuthLoading());

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setString('user', jsonEncode(user.toJson()));
        await Prefs.setString('token', data['token']);

        emit(Authenticated(
          user: user,
          token: data['token'],
        ));
      } else {
        emit(NotAuthenticated());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future logout() async {
    emit(AuthLoading());

    await Prefs.remove('user');
    await Prefs.remove('token');

    emit(AuthInitial());
  }
}
