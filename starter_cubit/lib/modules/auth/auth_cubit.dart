import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_cubit/models/user.dart';
import 'package:starter_cubit/utils/prefs.dart';

import 'auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service;

  AuthCubit(this._service) : super(AuthInitial());

  Future<void> register(String username, String email, String password) async {
    emit(AuthLoading());

    try {
      final data = await _service.register(username, email, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        emit(Authenticated(user));
      } else {
        emit(NotAuthenticated());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      final data = await _service.login(username, password);

      if (data is Map && data.containsKey('token')) {
        final user = User.fromJson(data);

        await Prefs.setInt('user_id', data['id']);
        await Prefs.setString('username', data['username']);
        await Prefs.setString('token', data['token']);

        emit(Authenticated(user));
      } else {
        emit(NotAuthenticated());
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    await Prefs.remove('user_id');
    await Prefs.remove('username');
    await Prefs.remove('token');

    emit(AuthInitial());
  }
}
