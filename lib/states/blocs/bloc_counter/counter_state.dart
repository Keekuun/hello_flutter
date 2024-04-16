part of 'counter_bloc.dart';

sealed class CounterState extends Equatable {
  final int count;
  final String msg;
  const CounterState(this.count, this.msg);
}

final class CounterInitial extends CounterState {
  const CounterInitial(int count) : super(count, 'Bloc Counter');

  @override
  List<Object> get props => [count, msg];
}
