import 'package:flutter/material.dart';

import 'getx_counter.dart';
import 'getx_counter1.dart';
import 'getx_counter2.dart';
import 'getx_list_item.dart';

class GetxPage extends StatelessWidget {
  const GetxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GetxListItem(
          title: 'Getx Counter',
          subtitle: 'Getx Counter demo',
          icon: Icons.numbers,
          target: GetxCounter(),
        ),
        GetxListItem(
          title: 'Getx Counter1',
          subtitle: 'Getx Counter1 demo',
          icon: Icons.numbers,
          target: GetxCounter1(),
        ),
        GetxListItem(
          title: 'Getx Counter2',
          subtitle: 'Getx Counter2 demo',
          icon: Icons.numbers,
          target: GetxCounter2(),
        ),
      ],
    );
  }
}
