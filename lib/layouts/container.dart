import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ContainerDemo extends HookWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 250,
        height: 500,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ],
            gradient: const LinearGradient(colors: <Color>[
              Colors.blueAccent,
              Colors.greenAccent,
            ])),
        child: Column(children: <Widget>[
          Container(
            width: 200,
            // color 和 decoration 二者不可同时存在
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(color: Colors.redAccent, width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5)
                ]),
            child: const Center(
              child: Text(
                'Hello World',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 100,
            width: 200,
            // color: Colors.white70,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 30),
            padding: const EdgeInsets.all(20),
            foregroundDecoration: BoxDecoration(
              backgroundBlendMode: BlendMode.colorBurn,
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.red.withOpacity(0.5),
                  Colors.blue.withOpacity(0.5)
                ],
              ),
              shape: BoxShape.circle,
            ),
            transform: Matrix4.rotationZ(0.4),
            child: const Center(
                child: Text('hello',
                    style: TextStyle(fontSize: 16, color: Colors.white))),
          ),
          Container(
            height: 100,
            // color: Colors.white70,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                )
              ],
              backgroundBlendMode: BlendMode.darken,
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.red.withOpacity(0.5),
                  Colors.blue.withOpacity(0.5)
                ],
              ),
              shape: BoxShape.rectangle,
            ),
            transform: Matrix4.rotationZ(0.2),
            child: const Center(
                child: Text('world',
                    style: TextStyle(fontSize: 16, color: Colors.white))),
          )
        ]),
      ),
    );
  }
}
