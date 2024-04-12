import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yay! A SnackBar!')));
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
        onPressed: () {
          launchUrl(Uri.parse('https://flutter.cn/'));
        },
        child: const Text('文本按钮-模拟a标签',
            style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red)),
      ),
      const Divider(),
      TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.star),
          label: const Text('图标按钮')),
      TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.home),
          label: const Text('回到home')),
      TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.not_interested),
          label: const Text('禁用')),
      const Divider(),
      ElevatedButton(onPressed: () {}, child: const Text('阴影按钮1')),
      const SizedBox(width: 10),
      ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue)),
          child: const Text('阴影按钮2', style: TextStyle(color: Colors.white))),
      const SizedBox(width: 10),
      const ElevatedButton(onPressed: null, child: Text('禁用')),
      const Divider(),
      SizedBox(
        height: 100,
        width: double.infinity,
        child: FloatingActionButton(
          elevation: 20,
          tooltip: '浮动按钮, 改变尺寸',
          onPressed: () {},
          child: SizedBox(
            height: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.green])),
              child: const Row(
                children: [
                  Icon(Icons.sunny, size: 24, color: Colors.yellow),
                  Spacer(),
                  Text('浮动按钮, 改变尺寸')
                ],
              ),
            ),
          ),
        ),
      ),
      const Divider(),
      OverflowBar(
        spacing: 20,
        children: [
          OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "边框按钮1",
                style: TextStyle(color: Colors.redAccent),
              )),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1, color: Colors.red)),
            onPressed: () {},
            child: const Text(
              "边框按钮2",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const OutlinedButton(
            onPressed: null,
            child: Text(
              "禁用",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      )
    ]);
  }
}
