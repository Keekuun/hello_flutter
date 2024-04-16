part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();
}

class IncrementEvent extends CounterEvent {
  @override
  List<Object> get props => [];
}

class DecrementEvent extends CounterEvent {
  @override
  List<Object> get props => [];
}