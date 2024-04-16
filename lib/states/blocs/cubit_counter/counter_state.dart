part of 'counter_cubit.dart';

sealed class CounterState extends Equatable {
  final int count;
  final String msg;
  const CounterState(this.count, this.msg);
}

final class CounterInitial extends CounterState {
  const CounterInitial(count) : super(count, 'Cubit Counter');

  @override
  List<Object> get props => [count, msg];
}
