import 'dart:developer';

import 'package:flutter/material.dart';

import 'lifecycle1.dart';

class LifecycleDemo3 extends StatefulWidget {
  const LifecycleDemo3({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LifecycleDemo3> createState() {
    log('create state');
    return _ExampleState();
  }
}

class _ExampleState extends State<LifecycleDemo3> {
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
                        context, '/Others/Lifecycle1');
                  },
                  child: const Text('去lifecycle1页面'),
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
        const InheritedParent(),
        // --- addition ---
      ],
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo3 oldWidget) {
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

class MyInheritedWidget extends InheritedWidget {
  final String data;

  const MyInheritedWidget({
    required this.data,
    required super.child,
    super.key,
  });

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    bool update = data != oldWidget.data;
    log('updateShouldNotify called. Update: $update');
    return update;
  }
}

class InheritedChild extends StatefulWidget {
  const InheritedChild({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<InheritedChild> createState() {
    log('inherited child create state');
    return _InheritedChildState();
  }
}

class _InheritedChildState extends State<InheritedChild> {
  _InheritedChildState() {
    log('inherited child constructor, mounted: $mounted');
  }

  @override
  void initState() {
    super.initState();
    log('inherited child initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('inherited child didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    log('inherited child setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    log('inherited child build');
    final inheritedData = MyInheritedWidget.of(context).data;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        inheritedData,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant InheritedChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('inherited child didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    log('inherited child deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    log('inherited child dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    log('inherited child reassemble, mounted: $mounted');
  }
}

class InheritedParent extends StatefulWidget {
  const InheritedParent({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<InheritedParent> createState() {
    log('inherited parent create state');
    return _InheritedParentState();
  }
}

class _InheritedParentState extends State<InheritedParent> {
  String parentData = 'Hello, world!';

  _InheritedParentState() {
    log('inherited parent constructor, mounted: $mounted');
  }

  void updateParentData() {
    setState(() {
      parentData = 'Updated data';
    });
  }

  @override
  void initState() {
    super.initState();
    log('inherited parent initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('inherited parent didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    log('inherited parent setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    log('inherited parent build');

    return Column(
      children: [
        MyInheritedWidget(
          data: parentData,
          child: const InheritedChild(),
        ),
        ElevatedButton(
          onPressed: updateParentData,
          child: const Text('Update Parent Data'),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant InheritedParent oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('inherited parent didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    log('inherited parent deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    log('inherited parent dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    log('inherited parent reassemble, mounted: $mounted');
  }
}
