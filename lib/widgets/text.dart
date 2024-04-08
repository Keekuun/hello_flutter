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
      )
    ]);
  }
}
