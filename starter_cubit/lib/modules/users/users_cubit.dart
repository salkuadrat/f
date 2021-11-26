import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'users_service.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersService _service;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  UsersCubit(this._service) : super(UsersInitial()) {
    _init();
    _trigger();
  }

  Future<void> _init() async {
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

  Future<void> _fetch() async {
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
}
