import 'package:equatable/equatable.dart';
import 'package:starter_riverpod/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
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
}
