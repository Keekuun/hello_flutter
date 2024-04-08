import 'package:flutter/material.dart';

class IconDemo extends StatelessWidget {
  const IconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.star,
        size: 50,
        color: Colors.red,
      ),
      Icon(
        Icons.star,
        weight: 900,
        shadows: [
          Shadow(color: Colors.green, offset: Offset(2, 2), blurRadius: 5),
        ],
        size: 32,
        color: Colors.yellowAccent,
      ),
      Icon(
        Icons.star,
        weight: 900,
        shadows: [
          Shadow(color: Colors.green, offset: Offset(2, 2), blurRadius: 5),
        ],
        size: 40,
        color: Colors.cyanAccent,
      ),
      Icon(
        Icons.star,
        weight: 900,
        shadows: [
          Shadow(color: Colors.green, offset: Offset(2, 2), blurRadius: 5),
        ],
        size: 40,
        color: Colors.blue,
      ),
      Icon(
        Icons.star,
        weight: 900,
        shadows: [
          Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 5),
          Shadow(color: Colors.red, offset: Offset(4, 4), blurRadius: 8),
          Shadow(color: Colors.grey, offset: Offset(0, 10), blurRadius: 20),
        ],
        size: 40,
        color: Colors.purple,
      )
    ]);
  }
}
