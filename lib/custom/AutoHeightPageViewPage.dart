import 'package:flutter/material.dart';

import 'AutoHeightPageView.dart';

class AutoHeightPageViewPage extends StatefulWidget {
  const AutoHeightPageViewPage({super.key});

  @override
  State<StatefulWidget> createState() => AutoHeightPageViewState();
}

class AutoHeightPageViewState extends State<AutoHeightPageViewPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AutoHeightPageView(
                pageController: _pageController,
                children: [
                  Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("第一个界面"),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("向右滑动"),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text("第一个界面"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.green,
                      height: 300,
                      child: const Center(child: Text('第二个界面'))),
                ],
              ),
              Image.network(
                'https://ossweb-img.qq.com/images/lol/web201310/skin/big10008.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ));
  }
}
