import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:starter_riverpod/modules/users/users.dart';

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
}
