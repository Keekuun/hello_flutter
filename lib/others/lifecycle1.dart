import 'dart:developer';

import 'package:flutter/material.dart';

class LifecycleDemo1 extends StatefulWidget {
  const LifecycleDemo1({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LifecycleDemo1> createState() {
    log('create state');
    return _ExampleState();
  }
}

class _ExampleState extends State<LifecycleDemo1> {
  int _counter = 0;

  _ExampleState() {
    log('constructor, mounted: $mounted');
  }

  @override
  void initState() {
    super.initState();
    log('initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    log('setState');
    super.setState(fn);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('build method');

    return Column(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),

              // counter text
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // navigation button
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/Others/Lifecycle2');
                  },
                  child: const Text('去lifecycle2页面'),
                ),
              ),
            ],
          ),
        ),
        FloatingActionButton(
          heroTag: 'LifecycleDemo1',
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
      ],
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    log('deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    log('dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    log('reassemble, mounted: $mounted');
  }
}
