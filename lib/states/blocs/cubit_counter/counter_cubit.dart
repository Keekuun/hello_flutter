import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitial(0));

  void increment() {
    emit(CounterInitial(state.count + 1));
  }

  void decrement() {
    emit(CounterInitial(state.count - 1));
  }
}
