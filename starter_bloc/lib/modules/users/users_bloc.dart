import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:starter_bloc/models/user.dart';
import 'package:starter_bloc/modules/users/users.dart';

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
}
