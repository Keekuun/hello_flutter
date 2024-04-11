import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
       Row(
         children: [
           ListTile(title: Text('普通按钮组件'),),
         ],
       )
      ],
    );
  }
}
