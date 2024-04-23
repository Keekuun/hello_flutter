import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GridDemo extends StatelessWidget {
  const GridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0
    ];
    return GridView.count(
      // SingleChildScrollView 嵌套 GridView 需要禁用滚动
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      padding: const EdgeInsets.all(0),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: list.map((e) {
        return GestureDetector(
          onTap: () {
            Fluttertoast.showToast(
                msg: "You clicked ${e.toString()}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
                textColor: Colors.white,
                fontSize: 16.0);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              color:
                  Colors.teal[100 * (list.indexOf(e) % 10)] ?? Colors.redAccent,
              border: Border.all(color: Colors.blue, width: 1),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
              ],
            ),
            alignment: Alignment.center,
            child: Text(e.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ),
        );
      }).toList(),
    );
  }
}
