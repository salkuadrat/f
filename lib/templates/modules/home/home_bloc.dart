import 'dart:io';

/// generate template for module home
void homeBloc(String project, String dir) {
  _home(project, dir);
  _bloc(project, dir);
  _event(project, dir);
  _state(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_bloc.dart';''');
}

void _bloc(String project, String dir) {
  File('$dir/home_bloc.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  
  HomeBloc() : super(const HomeState()) {
    on<IncrementCounter>((event, emit) {
      emit(state.increment());
    });

    on<DecrementCounter>((event, emit) {
      emit(state.decrement());
    });
  }

  void incrementCounter() {
    add(IncrementCounter());
  }

  void decrementCounter() {
    add(DecrementCounter());
  }
}''');
}

void _event(String project, String dir) {
  File('$dir/home_event.dart').writeAsStringSync('''
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncrementCounter extends HomeEvent {}

class DecrementCounter extends HomeEvent {}''');
}

void _state(String project, String dir) {
  File('$dir/home_state.dart').writeAsStringSync('''
part of 'home_bloc.dart';

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
