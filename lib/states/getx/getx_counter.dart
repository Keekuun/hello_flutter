import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxCounter extends StatelessWidget {
  var count = 0.obs;

  GetxCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: Obx(
            () => Text("${count.value}", style: const TextStyle(fontSize: 50))),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => count++,
      ),
    );
  }
}
