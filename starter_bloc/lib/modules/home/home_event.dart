part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncrementCounter extends HomeEvent {}

class DecrementCounter extends HomeEvent {}
