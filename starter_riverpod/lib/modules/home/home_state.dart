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
}
