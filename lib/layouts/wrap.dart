import 'dart:developer';

import 'package:flutter/material.dart';

class WrapDemo extends StatelessWidget {
  const WrapDemo({super.key});

  @override
  Widget build(BuildContext context) {
    const localeImg = 'assets/images/logo.jpg';

    return Wrap(spacing: 10, runSpacing: 10, children: [
      Image.asset(localeImg, width: 100),
      const Chip(
        label: Text('wrap chip'),
        elevation: 5,
        shadowColor: Colors.grey,
      ),
      Chip(
        label: const Icon(Icons.favorite, color: Colors.red),
        onDeleted: () {
          log('deleted');
        },
        deleteButtonTooltipMessage: 'Delete',
        color: MaterialStateProperty.all(Colors.blue),
        backgroundColor: Colors.white,
        deleteIconColor: Colors.redAccent,
        elevation: 10,
        shadowColor: Colors.green,
        side: const BorderSide(color: Colors.green, width: 2), // iconTheme
      ),
      const Chip(label: Text('chip3'), avatar: CircleAvatar(child: Text('A'))),
      const Chip(label: Text('chip4'), avatar: CircleAvatar(child: Text('B'))),
      const Chip(label: Text('chip4'), avatar: CircleAvatar(child: Text('C'))),
      const Chip(label: Text('chip4'), avatar: CircleAvatar(child: Text('D'))),
      const Chip(
          label: Text('chip4'),
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('E'))),
    ]);
  }
}
