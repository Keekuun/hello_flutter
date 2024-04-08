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
      const SizedBox(
        height: 10,
      ),
      RichText(
          text: const TextSpan(
              text: '复杂使用：',
              style: TextStyle(color: Colors.red, fontSize: 16),
              children: [
            TextSpan(text: ' 使用图标', style: TextStyle(color: Colors.blue)),
            WidgetSpan(
                child: Icon(
              Icons.star,
              size: 30,
              color: Colors.red,
            )),
            TextSpan(text: ' 使用其他组件', style: TextStyle(color: Colors.orange)),
            WidgetSpan(
                child: Icon(
              Icons.people,
              size: 20,
              color: Colors.grey,
            )),
            WidgetSpan(
                child: SelectableText('*我可以被选中，其他的不行*',
                    style: TextStyle(color: Colors.green))),
            WidgetSpan(
                child: Icon(
              Icons.ac_unit_outlined,
              size: 30,
              color: Colors.white60,
            ))
          ])),
    ]);
  }
}
