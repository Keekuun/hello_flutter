import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextDemo extends HookWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        'Hello Flutter Text',
        textAlign: TextAlign.left,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 24,
        ),
      ),
      const Text(
        'Hello Flutter Text',
        textAlign: TextAlign.left,
        style: TextStyle(
            decoration: TextDecoration.lineThrough,
            fontStyle: FontStyle.italic,
            fontSize: 24,
            color: Colors.purple),
      ),
      SizedBox(
        width: 400,
        child: Text(
          'Hello Flutter Text',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 24,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 400,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: const Text(
          'Hello Flutter Text Hello Flutter Text Hello Flutter Text Hello Flutter Text',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 24, color: Colors.black),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: 400,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('displayLarge', style: Theme.of(context).textTheme.displayLarge),
          Text('displayMedium',
              style: Theme.of(context).textTheme.displayMedium),
          Text('displayMedium',
              style: Theme.of(context).textTheme.displayMedium),
          Text('displaySmall', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(
            height: 10,
          ),
          Text('headlineLarge',
              style: Theme.of(context).textTheme.headlineLarge),
          Text('headlineMedium',
              style: Theme.of(context).textTheme.headlineMedium),
          Text('headlineSmall',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(
            height: 10,
          ),
          Text('titleLarge', style: Theme.of(context).textTheme.titleLarge),
          Text('titleMedium', style: Theme.of(context).textTheme.titleMedium),
          Text('titleSmall', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(
            height: 10,
          ),
          Text('bodyLarge', style: Theme.of(context).textTheme.bodyLarge),
          Text('bodyMedium', style: Theme.of(context).textTheme.bodyMedium),
          Text('bodySmall', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            height: 10,
          ),
          Text('bodySmall', style: Theme.of(context).textTheme.labelLarge),
          Text('labelMedium', style: Theme.of(context).textTheme.labelMedium),
          Text('labelSmall', style: Theme.of(context).textTheme.labelSmall),
        ]),
      )
    ]);
  }
}
