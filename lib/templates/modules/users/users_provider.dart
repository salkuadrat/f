import 'dart:io';

/// generate template for module users
void usersProvider(String project, String dir) {
  _users(project, dir);
  _state(project, dir);
}

void _users(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
export 'users_state.dart';
export 'users_service.dart';''');
}

void _state(String project, String dir) {
  File('$dir/users_state.dart').writeAsStringSync('''
import 'package:flutter/foundation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:$project/models/user.dart';
import 'package:$project/modules/users/users.dart';

class UsersState extends ChangeNotifier {
  
  final UsersService _service;

  int _page = 1;
  String _query = '';
  List<User> _items = [];

  bool _isEmpty = false;
  bool _isFailed = false;
  bool _isLoading = false;
  bool _hasReachedMax = false;

  int get page => _page;
  int get count => _items.length;
  String get query => _query;
  List<User> get items => _items;

  bool get isEmpty => _isEmpty;
  bool get isFailed => _isFailed;
  bool get isLoading => _isLoading;
  bool get hasReachedMax => _hasReachedMax;

  bool get isFirstPage => _page == 1;
  bool get isLoadingFirst => _isLoading && isFirstPage;
  bool get isLoadingMore => _isLoading && _page > 1;

  User item(int index) => _items[index];

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  UsersState(this._service) {
    _init();
    _trigger();
  }

  Future<void> _init() async {
    _startLoading();

    final items = await _service.fetch('', 1);

    if (items == null) {
      _isFailed = true;
    } else if (items.isEmpty) {
      _isEmpty = true;
    } else {
      _page = 2;
      _query = '';
      _items = [...items];
    }

    notifyListeners();
    _stopLoading();
  }

  Future<void> refresh([String? query]) async {
    _startLoading();

    final items = await _service.fetch(query ?? '', 1);

    if (items != null && items is List && items.isNotEmpty) {
      _page = 2;
      _query = query ?? '';
      _items = [...items];
    }

    notifyListeners();
    _stopLoading();
  }

  Future<void> fetch() async {
    if (!_isLoading) {
      _startLoading();

      final items = await _service.fetch(_query, _page);

      if (items != null) {
        if (items.isEmpty) {
          _isEmpty = false;
          _isFailed = false;
          _hasReachedMax = true;
        } else {
          _page = _page + 1;
          _items = [..._items, ...items];

          _isEmpty = false;
          _isFailed = false;
          _hasReachedMax = false;
        }
      }

      notifyListeners();
      _stopLoading();
    }
  }

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void _trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = count - 1;

      final isAtBottom = pos.isNotEmpty && pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !isLoading && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    _page = 1;
    _items = [];
    _isEmpty = false;
    _isFailed = false;
    _isLoading = false;
    super.dispose();
  }
}''');
}
