import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  const StackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white54,
        elevation: 4,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                kToolbarHeight -
                kBottomNavigationBarHeight -
                40,
            color: Colors.blue[100],
            child: Stack(alignment: Alignment.center, children: [
              Container(
                width: 300,
                height: 300,
                color: Colors.lightGreen,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(alignment: Alignment.topLeft, children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    )
                  ]),
                ),
              ),
              Container(
                width: 200,
                height: 200,
                // color: Colors.redAccent,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.redAccent,
                ),
              ),
              Container(
                  width: 100,
                  height: 100,
                  color: Colors.black,
                  child: const Center(
                    child: Text('stack',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  )),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(alignment: Alignment.topRight, children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  )
                ]),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(alignment: Alignment.bottomLeft, children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  )
                ]),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(alignment: Alignment.bottomRight, children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.yellow,
                  )
                ]),
              ),
            ]),
          )
        ]));
  }
}
