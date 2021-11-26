import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:starter_getx/models/user.dart';
import 'package:starter_getx/modules/users/users.dart';

class UsersController extends GetxController {
  final UsersService _service;

  final _page = 1.obs;
  final _query = ''.obs;
  final _items = <User>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = false.obs;
  final _hasReachedMax = false.obs;

  UsersController(this._service);

  int get page => _page.value;
  int get count => _items.length;
  String get query => _query.value;
  List<User> get items => _items.toList();

  bool get isFirstPage => page == 1;
  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get isLoadingMore => isLoading && page > 1;
  bool get hasReachedMax => _hasReachedMax.value;

  User item(int index) => _items[index];

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void onReady() {
    super.onReady();
    _init();
    _trigger();
  }

  void _startLoading() {
    _isLoading.value = true;
  }

  void _stopLoading() {
    _isLoading.value = false;
  }

  Future<void> _init() async {
    _startLoading();

    final items = await _service.fetch(query, 1);

    if (items == null) {
      _isFailed.value = true;
    } else if (items.isEmpty) {
      _isEmpty.value = true;
    } else {
      _items.addAll(items);
      _page.value = 2;
    }

    _stopLoading();
  }

  Future<void> reload([String? query]) async {
    _startLoading();

    final items = await _service.fetch(query ?? '', 1);

    if (items != null && items.isNotEmpty) {
      _items.clear();
      _items.addAll(items);
      _query.value = query ?? '';
      _isEmpty.value = false;
      _isFailed.value = false;
      _hasReachedMax.value = false;
      _page.value = 2;
    }

    _stopLoading();
  }

  Future<void> _loadPerPage() async {
    _startLoading();

    final items = await _service.fetch(query, page);

    if (items != null) {
      if (items.isEmpty) {
        _isEmpty.value = false;
        _isFailed.value = false;
        _hasReachedMax.value = true;
      } else {
        _items.addAll(items);
        _isEmpty.value = false;
        _isFailed.value = false;
        _hasReachedMax.value = false;
        _page.value++;
      }
    }

    _stopLoading();
  }

  void _trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = count - 1;

      final isAtBottom = pos.isNotEmpty && pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !isLoading && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        _loadPerPage();
      }
    });
  }
}
