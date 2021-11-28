import 'dart:io';

/// generate template for module users
void usersBloc(String project, String dir) {
  _users(project, dir);
  _bloc(project, dir);
  _event(project, dir);
  _state(project, dir);
}

void _users(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
export 'users_bloc.dart';
export 'users_service.dart';''');
}

void _bloc(String project, String dir) {
  File('$dir/users_bloc.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/users/users.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final UsersService _service;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  UsersBloc(this._service) : super(UsersInitial()) {
    on<InitUsers>((event, emit) async {
      await emit.onEach(_onInit(event), onData: emit);
    });

    on<RefreshUsers>((event, emit) async {
      await emit.onEach(_onRefresh(event), onData: emit);
    });

    on<FetchUsers>((event, emit) async {
      await emit.onEach(_onFetch(event), onData: emit);
    });

    add(InitUsers());
    _trigger();
  }

  Future<void> refresh([String? query]) async {
    add(RefreshUsers(query: query ?? ''));
  }

  Stream<UsersState> _onInit(InitUsers event) async* {
    yield UsersLoading();

    final items = await _service.fetch('', 1);

    if (items == null) {
      yield UsersFailed();
    } else if (items.isEmpty) {
      yield UsersEmpty();
    } else {
      yield UsersFetched(
        page: 2,
        query: '',
        items: items,
      );
    }
  }

  Stream<UsersState> _onRefresh(RefreshUsers event) async* {
    final currentState = state;

    yield UsersLoading();

    final items = await _service.fetch(event.query, 1);

    if (items is List && items!.isNotEmpty) {
      yield UsersFetched(
        page: 2,
        query: event.query,
        items: items,
      );
    } else {
      yield currentState;
    }
  }

  Stream<UsersState> _onFetch(FetchUsers event) async* {
    yield UsersLoadingMore(
      page: state.page,
      query: state.query,
      items: state.items,
    );

    final items = await _service.fetch('', state.page);

    if (items != null) {
      if (items.isEmpty) {
        yield UsersReachedMax(
          page: state.page,
          query: state.query,
          items: state.items,
        );
      } else {
        yield UsersFetched(
          page: state.page + 1,
          query: state.query,
          items: [...state.items, ...items],
        );
      }
    }
  }

  void _trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.isNotEmpty && pos.last.index == lastIndex;
      final isLoading = state is UsersLoading || state is UsersLoadingMore;
      final hasReachedMax = state is UsersReachedMax;
      
      final isLoadMore = isAtBottom && !isLoading && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        add(FetchUsers());
      }
    });
  }

  EventTransformer<UserEvent> throttle<UserEvent>() {
    return (events, mapper) => events
        .throttleTime(const Duration(
          milliseconds: 500,
        ))
        .flatMap(mapper);
  }
}''');
}

void _event(String project, String dir) {
  File('$dir/users_event.dart').writeAsStringSync('''
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
}''');
}

void _state(String project, String dir) {
  File('$dir/users_state.dart').writeAsStringSync('''
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

class UsersEmpty extends UsersState {}''');
}
