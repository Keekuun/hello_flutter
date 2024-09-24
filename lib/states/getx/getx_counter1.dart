import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'counter_logic.dart';

class GetxCounter1 extends StatelessWidget {
  final CounterLogic logic = Get.put(CounterLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('计数器-简单式')),
      body: Center(
        child: GetBuilder<CounterLogic>(builder: (logic) {
          return Text(
            '点击了 ${logic.count} 次',
            style: const TextStyle(fontSize: 30.0),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.increase(),
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
