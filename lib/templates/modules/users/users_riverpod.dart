import 'dart:io';

/// generate template for module users
void usersRiverpod(String project, String dir) {
  _users(project, dir);
  _notifier(project, dir);
  _provider(project, dir);
  _state(project, dir);
}

void _users(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
export 'users_notifier.dart';
export 'users_provider.dart';
export 'users_state.dart';
export 'users_service.dart';''');
}

void _notifier(String project, String dir) {
  File('$dir/users_notifier.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:$project/modules/users/users.dart';

class UsersNotifier extends StateNotifier<UsersState> {

  final UsersService _service;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  UsersNotifier(this._service) : super(const UsersState()) {
    _init();
    _trigger();
  }

  Future<void> _init() async {
    state = UsersLoading();

    final items = await _service.fetch(state.query, 1);

    if (items == null) {
      state = UsersFailed();
    } else if (items.isEmpty) {
      state = UsersEmpty();
    } else {
      state = UsersFetched(
        page: 2,
        query: state.query,
        items: items,
      );
    }
  }

  Future<void> refresh([String? query]) async {
    final currentState = state;
    final items = await _service.fetch(query, 1);

    if (items is List && items!.isNotEmpty) {
      state = UsersFetched(
        page: 2,
        query: state.query,
        items: items,
      );
    } else {
      state = currentState;
    }
  }

  Future<void> _fetch() async {
    state = UsersLoadingMore(
      page: state.page,
      query: state.query,
      items: state.items,
    );

    final items = await _service.fetch(state.query, state.page);

    if (items != null) {
      if (items.isEmpty) {
        state = UsersReachedMax(
          page: state.page,
          query: state.query,
          items: state.items,
        );
      } else {
        state = UsersFetched(
          page: state.page + 1,
          query: state.query,
          items: [...state.items, ...items],
        );
      }
    }
  }

  void _trigger() {
    itemPositionsListener.itemPositions.addListener(() async {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.isNotEmpty && pos.last.index == lastIndex;
      final isLoading = state is UsersLoading || state is UsersLoadingMore;
      final hasReachedMax = state is UsersReachedMax;

      final isLoadMore = isAtBottom && !isLoading && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        await _fetch();
      }
    });
  }
}''');
}

void _provider(String project, String dir) {
  File('$dir/users_provider.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/users/users.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>(
  (ref) => UsersNotifier(UsersService()),
);''');
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
