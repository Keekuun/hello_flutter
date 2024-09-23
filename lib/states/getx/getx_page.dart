import 'package:flutter/material.dart';

import 'getx_counter.dart';
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
      ],
    );
  }
}
