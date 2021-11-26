import 'dart:io';

/// generate template for module home
void homeCubit(String project, String dir) {
  _home(project, dir);
  _cubit(project, dir);
  _state(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_cubit.dart';
export 'home_state.dart';''');
}

void _cubit(String project, String dir) {
  File('$dir/home_cubit.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void incrementCounter() {
    emit(state.increment());
  }

  void decrementCounter() {
    emit(state.decrement());
  }
}''');
}

void _state(String project, String dir) {
  File('$dir/home_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int counter;

  const HomeState({this.counter = 0});

  HomeState increment() => copyWith(counter: counter + 1);

  HomeState decrement() => copyWith(counter: counter - 1);

  HomeState copyWith({int? counter}) {
    return HomeState(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [counter];
}''');
}
