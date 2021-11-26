import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/modules/home/home.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  void incrementCounter() {
    state = state.incrementCounter();
  }

  void decrementCounter() {
    state = state.decrementCounter();
  }

  @override
  void dispose() {
    state = state.reset();
    super.dispose();
  }
}
