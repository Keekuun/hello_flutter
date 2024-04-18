import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_flutter/states/blocs/bloc_counter/counter_bloc.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const Column(
        children: [
          CounterView(),
          Divider(),
          CounterView(),
        ],
      ),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          const Text('You have pushed the button this many times:'),
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
            return Chip(
                label: Text('${state.msg}: ${state.count}'),
                avatar: const Icon(Icons.favorite));
          }),
          ElevatedButton(
            onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
            child: const Text('Increment'),
          ),
          ElevatedButton(
            onPressed: () => context.read<CounterBloc>().add(DecrementEvent()),
            child: const Text('Decrement'),
          )
        ]));
  }
}
