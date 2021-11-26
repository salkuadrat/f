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
}
