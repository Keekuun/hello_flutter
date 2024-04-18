import 'dart:developer';

import 'package:flutter/material.dart';

class LifecycleDemo2 extends StatefulWidget {
  const LifecycleDemo2({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LifecycleDemo2> createState() {
    log('create state');
    return _ExampleState();
  }
}

class _ExampleState extends State<LifecycleDemo2> {
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

  String text = 'hello!';

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
                        context, '/Others/Lifecycle3');
                  },
                  child: const Text('去lifecycle3页面'),
                ),
              ),
            ],
          ),
        ),
        FloatingActionButton(
          heroTag: 'LifecycleDemo2',
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),

        // --- addition ---

        ChildDemo(text: text),
        // const ChildDemo(text: 'constant child'),

        // Button to update text value
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() => text += ' hello!');
          },
          child: const Text('Update Text (parent)'),
        ),

        // --- addition ---
      ],
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo2 oldWidget) {
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

class ChildDemo extends StatefulWidget {
  const ChildDemo({
    super.key,
    required this.text,
  });

  final String text;

  @override
  // ignore: no_logic_in_create_state
  State<ChildDemo> createState() {
    log('create child state');
    return _ChildState();
  }
}

class _ChildState extends State<ChildDemo> {
  @override
  void initState() {
    super.initState();
    log('child initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('child didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    log('child setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    log('child build method');
    return Column(
      children: <Widget>[
        // text data displayed
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'child: ${widget.text}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        // Update button
        ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('Update from child')),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant ChildDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('child didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    log('child deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    log('child dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    log('child reassemble, mounted: $mounted');
  }
}
