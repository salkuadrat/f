part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitUsers extends UsersEvent {}

class FetchUsers extends UsersEvent {}

class RefreshUsers extends UsersEvent {
  final String query;

  RefreshUsers({this.query = ''});

  @override
  List<Object> get props => [query];
}
