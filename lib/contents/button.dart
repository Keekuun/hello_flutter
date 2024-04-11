import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Yay! A SnackBar!')));
          },
          child: const Text('文本按钮-默认主题')),
      const TextButton(onPressed: null, child: Text('文本按钮禁用')),
      TextButton(
          onPressed: () {
            Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          child: const Text('文本按钮-修改颜色', style: TextStyle(color: Colors.blue))),
      TextButton(
        onPressed: () {},
        child: const Text('文本按钮-模拟a标签',
            style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red)),
      ),
      const Divider(),
      TextButton.icon(
          onPressed: () {
          },
          icon: const Icon(Icons.star),
          label: const Text('图标按钮')),
      TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.home),
          label: const Text('图标按钮')),
      const Divider(),
      ElevatedButton(onPressed: () {}, child: const Text('阴影按钮1')),
      ElevatedButton(
          onPressed: () {
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: const Text('阴影按钮2', style: TextStyle(color: Colors.white))),
    ]);
  }
}
