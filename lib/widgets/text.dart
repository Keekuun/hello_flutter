import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextDemo extends HookWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello Flutter',
      style: TextStyle(
          fontSize: 24, color: Theme.of(context).colorScheme.primary),
    );
  }
}
