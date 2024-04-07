import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WrapPage extends HookWidget {
  final Widget child;
  final String title;
  final String? description;

  const WrapPage({
    super.key,
    required this.child,
    required this.title,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white,), onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        ),
      ),
      body: SingleChildScrollView(
        child: child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.star),
      ),
    );
  }
}
