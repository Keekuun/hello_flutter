import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterInitial(state.count + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterInitial(state.count - 1));
    });
  }
}
