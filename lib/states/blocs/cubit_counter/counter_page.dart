import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
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
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              // 使用圆形包裹
              return Chip(label: Text('${state.msg}: ${state.count}'), avatar: const Icon(Icons.favorite));
            }
          ),
          ElevatedButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Text('Increment'),
          ),
          ElevatedButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Text('Decrement'),
          )
        ]
      )
    );
  }
}

