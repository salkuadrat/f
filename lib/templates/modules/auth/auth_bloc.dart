import 'dart:io';

/// generate template for module auth
void authBloc(String project, String dir) {
  _auth(project, dir);
  _bloc(project, dir);
  _event(project, dir);
  _state(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_bloc.dart';
export 'auth_service.dart';''');
}

void _bloc(String project, String dir) {
  File('$dir/auth_bloc.dart').writeAsStringSync('''
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/utils/prefs.dart';

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
}''');
}

void _event(String project, String dir) {
  File('$dir/auth_event.dart').writeAsStringSync('''
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthRegister({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

class AuthLogin extends AuthEvent {
  final String username;
  final String password;

  AuthLogin({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class AuthLogout extends AuthEvent {}''');
}

void _state(String project, String dir) {
  File('$dir/auth_state.dart').writeAsStringSync('''
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class NotAuthenticated extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [message];
}''');
}
