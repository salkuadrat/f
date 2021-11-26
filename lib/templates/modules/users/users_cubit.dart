import 'dart:io';

/// generate template for module users
void usersCubit(String project, String dir) {
  _users(project, dir);
  _cubit(project, dir);
  _state(project, dir);
}

void _users(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
export 'users_cubit.dart';
export 'users_state.dart';
export 'users_service.dart';''');
}

void _cubit(String project, String dir) {
  File('$dir/users_cubit.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'users_service.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {

  final UsersService _service;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  UsersCubit(this._service) : super(UsersInitial()) {
    itemPositionsListener.itemPositions.addListener(() async {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoading = state is UsersLoading || state is UsersLoadingMore;
      final hasReachedMax = state is UsersReachedMax;
      final isLoadMore = isAtBottom && !isLoading && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        await loadPerPage();
      }
    });

    init();
  }

  Future<void> init() async {
    emit(UsersLoading());

    final items = await _service.fetch(state.query, 1);

    if (items == null) {
      emit(UsersFailed());
    } else if (items.isEmpty) {
      emit(UsersEmpty());
    } else {
      emit(UsersFetched(
        page: 2,
        query: state.query,
        items: items,
      ));
    }
  }

  Future<void> refresh([String? query]) async {
    final currentState = state;
    final items = await _service.fetch(query, 1);

    if (items is List && items!.isNotEmpty) {
      emit(UsersFetched(
        page: 2,
        query: state.query,
        items: items,
      ));
    } else {
      emit(currentState);
    }
  }

  Future<void> loadPerPage() async {
    emit(UsersLoadingMore(
      page: state.page,
      query: state.query,
      items: state.items,
    ));

    final items = await _service.fetch(state.query, state.page);

    if (items != null) {
      if (items.isEmpty) {
        emit(UsersReachedMax(
          page: state.page,
          query: state.query,
          items: state.items,
        ));
      } else {
        emit(UsersFetched(
          page: state.page + 1,
          query: state.query,
          items: [...state.items, ...items],
        ));
      }
    }
  }
}''');
}

void _state(String project, String dir) {
  File('$dir/users_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

import 'package:$project/models/user.dart';

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

  UsersState reset() => copyWith(page: 1);

  UsersState copyWith({
    int? page,
    String? query,
    List<User>? items,
  }) {
    return UsersState(
      page: page ?? this.page,
      query: query ?? this.query,
      items: items ?? this.items,
    );
  }

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

class UsersEmpty extends UsersState {}''');
}
