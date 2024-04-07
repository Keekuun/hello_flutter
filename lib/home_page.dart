import 'package:flutter/material.dart';
import 'package:hello_flutter/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        title: const Text(
          'hello flutter',
          style: TextStyle(color: Colors.white),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.home, color: Colors.black,), onPressed: () {
        //   Navigator.pushReplacementNamed(context, '/');
        // },
        // ),
      ),
      body: Center(
        child: ListView(
          children: routesMap.entries
              .toList()
              .map((d) =>
              Column(children: [
                Text(d.key),
                ...d.value.entries.toList().map((e) => ListTile(
                  title: Text(e.key),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/${d.key}/${e.key}');
                  },
                )),
              ]))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.star),
      ),
    );
  }
}
