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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('CounterView组件$index:', style: const TextStyle(fontSize: 18),),
            ],
          ),
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

