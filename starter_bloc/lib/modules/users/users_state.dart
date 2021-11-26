part of 'users_bloc.dart';

class UsersState extends Equatable {
  final int page;
  final String query;
  final List<User> items;

  int get count => items.length;
  User item(int index) => items[index];

  const UsersState({
    this.page = 1,
    this.query = '',
    this.items = const [],
  });

  @override
  List<Object> get props => [query, page, items];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersFetched extends UsersState {
  const UsersFetched({
    required int page,
    required String query,
    required List<User> items,
  }) : super(page: page, query: query, items: items);
}

class UsersLoadingMore extends UsersFetched {
  const UsersLoadingMore({
    required int page,
    required String query,
    required List<User> items,
  }) : super(page: page, query: query, items: items);
}

class UsersReachedMax extends UsersFetched {
  const UsersReachedMax({
    required int page,
    required String query,
    required List<User> items,
  }) : super(page: page, query: query, items: items);
}

class UsersFailed extends UsersState {}

class UsersEmpty extends UsersState {}
