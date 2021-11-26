import 'dart:io';

/// generate template for module home
void homeRiverpod(String project, String dir) {
  _home(project, dir);
  _notifier(project, dir);
  _provider(project, dir);
  _state(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_notifier.dart';
export 'home_provider.dart';
export 'home_state.dart';''');
}

void _notifier(String project, String dir) {
  File('$dir/home_notifier.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/home/home.dart';

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
}''');
}

void _provider(String project, String dir) {
  File('$dir/home_provider.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/home/home.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);''');
}

void _state(String project, String dir) {
  File('$dir/home_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {

  final int counter;

  const HomeState({this.counter = 0});

  HomeState incrementCounter() => copyWith(counter: counter + 1);
  HomeState decrementCounter() => copyWith(counter: counter - 1);
  HomeState reset() => copyWith(counter: 0);

  HomeState copyWith({int? counter}) =>
      HomeState(counter: counter ?? this.counter);

  @override
  List<Object?> get props => [counter];
}''');
}
