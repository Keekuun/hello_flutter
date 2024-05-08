import 'dart:developer';

import 'package:flutter/material.dart';

class PageViewDemo extends StatelessWidget {
  final page1Controller = PageController(initialPage: 0);
  final page2Controller = PageController(initialPage: 1);

  PageViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: page1Controller,
      onPageChanged: (index) {
        log(index.toString());
        if (index == 2) {
          page2Controller.jumpToPage(1);
        }
      },
      children: [
        Container(
          color: Colors.blue,
          child: const Center(
            child: Text('上下滑动', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          color: Colors.deepPurple,
          child: const Center(
            child: Text('继续滑动', style: TextStyle(color: Colors.white)),
          ),
        ),
        PageView(
          scrollDirection: Axis.horizontal,
          controller: page2Controller,
          reverse: false,
          onPageChanged: (index) {
            log(index.toString());
          },
          pageSnapping: true,
          children: [
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('上下左右', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.redAccent,
              child: const Center(
                child: Text('左右滑动', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              color: Colors.orange,
              child: const Center(
                child: Text('往回滑动', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
