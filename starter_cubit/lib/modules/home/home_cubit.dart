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
}
