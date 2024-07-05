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
          CounterView(1),
          Divider(),
          CounterView(2),
        ],
      ),
    );
  }
}

class CounterView extends StatelessWidget {
  final int index;
  const CounterView(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('CounterView组件$index:', style: const TextStyle(fontSize: 18),),
                ],
              ),
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
