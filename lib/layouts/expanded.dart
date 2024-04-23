import 'package:flutter/material.dart';

class ExpandedDemo extends StatelessWidget {
  const ExpandedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          kToolbarHeight -
          kBottomNavigationBarHeight -
          40,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white54,
                      offset: Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple]),
                ),
              )),
          const SizedBox(width: 10),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient:
                      const LinearGradient(colors: [Colors.red, Colors.orange]),
                ),
              ))
        ],
      ),
    );
  }
}
