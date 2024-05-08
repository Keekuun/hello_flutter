import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_flutter/utils/common.dart';

class WrapPage extends HookWidget {
  final Widget child;
  final String title;
  final String? description;

  const WrapPage({
    super.key,
    required this.child,
    required this.title,
    this.description = '',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () => goBack(context),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    kBottomNavigationBarHeight),
            child: Center(child: child)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => goBack(context),
          tooltip: '返回',
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}
