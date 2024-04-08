import 'package:flutter/material.dart';

class RichTextDemo extends StatelessWidget {
  const RichTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text.rich(TextSpan(
          text: '实现方式一：',
          style: TextStyle(color: Colors.black, fontSize: 24),
          children: [
            TextSpan(text: ' Hello', style: TextStyle(color: Colors.red)),
            TextSpan(text: ' Text.rich', style: TextStyle(color: Colors.green))
          ])),
      RichText(
          text: const TextSpan(
              text: '实现方式二：',
              style: TextStyle(color: Colors.red, fontSize: 24),
              children: [
            TextSpan(text: ' Hello', style: TextStyle(color: Colors.blue)),
            TextSpan(text: ' RichText', style: TextStyle(color: Colors.orange)),
          ])),
    ]);
  }
}
