import 'dart:io';

/// generate template for module auth
void authCubit(String project, String dir) {
  _auth(project, dir);
  _cubit(project, dir);
  _state(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_cubit.dart';
export 'auth_state.dart';
export 'auth_service.dart';''');
}

void _cubit(String project, String dir) {
  File('$dir/auth_cubit.dart').writeAsStringSync('''
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:$project/models/user.dart';
import 'package:$project/utils/utils.dart';

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
''');
}

void _state(String project, String dir) {
  File('$dir/auth_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

import 'package:$project/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
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
