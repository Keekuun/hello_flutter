import 'package:flutter/material.dart';

class IconDemo extends StatelessWidget {
  const IconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.star,
        size: 100,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
