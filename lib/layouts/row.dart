import 'dart:developer';

import 'package:flutter/material.dart';

class RowDemo extends StatefulWidget {
  const RowDemo({super.key});

  @override
  State<RowDemo> createState() => _RowDemoState();
}

class _RowDemoState extends State<RowDemo> {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  MainAxisSize mainAxisSize = MainAxisSize.max;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  VerticalDirection verticalDirection = VerticalDirection.down;
  TextDirection textDirection = TextDirection.ltr;
  TextBaseline? textBaseline;

  @override
  void initState() {
    log('MainAxisAlignment.values ${MainAxisAlignment.values}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight -
            40,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      // color: Color.fromRGBO(120, 120, 120, 0.8),
                      gradient: LinearGradient(
                        // 颜色从左到右渐变
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(107, 167, 141, 0.8),
                          Color.fromRGBO(174, 206, 250, 1.0)
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: mainAxisAlignment,
                      crossAxisAlignment: crossAxisAlignment,
                      mainAxisSize: mainAxisSize,
                      // CrossAxisAlignment 为 baseline 时，必须设置 textBaseline
                      textBaseline:
                          crossAxisAlignment == CrossAxisAlignment.baseline
                              ? TextBaseline.alphabetic
                              : null,
                      children: [
                        Container(
                          width: 50,
                          height: 100,
                          decoration:
                              const BoxDecoration(color: Colors.redAccent),
                        ),
                        Container(
                          width: 50,
                          height: 150,
                          decoration:
                              const BoxDecoration(color: Colors.blueAccent),
                        ),
                        Container(
                          width: 50,
                          height: 120,
                          decoration:
                              const BoxDecoration(color: Colors.greenAccent),
                        ),
                        const Text(
                          'row demo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // 占领剩余空间
            const Spacer(),
            Column(
              children: [
                ListTile(
                  title: const Text('MainAxisSize'),
                  trailing: DropdownButton<MainAxisSize>(
                    value: mainAxisSize,
                    onChanged: (MainAxisSize? value) {
                      if (value != null) {
                        setState(() {
                          mainAxisSize = value;
                        });
                      }
                    },
                    items: MainAxisSize.values.map((MainAxisSize value) {
                      return DropdownMenuItem<MainAxisSize>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'MainAxisAlignment',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: DropdownButton<MainAxisAlignment>(
                    value: mainAxisAlignment,
                    onChanged: (MainAxisAlignment? value) {
                      if (value != null) {
                        setState(() {
                          mainAxisAlignment = value;
                        });
                      }
                    },
                    items:
                        // MainAxisAlignment.values [MainAxisAlignment.start, MainAxisAlignment.end, MainAxisAlignment.center, MainAxisAlignment.spaceBetween, MainAxisAlignment.spaceAround, MainAxisAlignment.spaceEvenly]
                        MainAxisAlignment.values.map((MainAxisAlignment value) {
                      return DropdownMenuItem<MainAxisAlignment>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                    title: const Row(children: [
                      Text(
                        'CrossAxisAlignment',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Tooltip(
                        message:
                            "if crossAxisAlignment == CrossAxisAlignment.baseline then textBaseline must not be null",
                        child: Icon(Icons.info_outline, color: Colors.blue),
                      )
                    ]),
                    trailing: DropdownButton<CrossAxisAlignment>(
                        value: crossAxisAlignment,
                        onChanged: (CrossAxisAlignment? value) {
                          if (value != null) {
                            setState(() {
                              crossAxisAlignment = value;
                            });
                          }
                        },
                        items: CrossAxisAlignment.values
                            .map((CrossAxisAlignment value) {
                          return DropdownMenuItem<CrossAxisAlignment>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList())),
                // CrossAxisAlignment 为 baseline 时，必须设置 textBaseline
              ],
            )
          ],
        ),
      ),
    );
  }
}
