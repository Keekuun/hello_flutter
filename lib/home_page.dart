import 'package:flutter/material.dart';
import 'package:hello_flutter/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
          children: routesList.map((d) {
            var id = d['id']! as String;
            var title = d['title']! as String;
            var icon = d['icon']! as Icon;
            var children = d['children']! as List<dynamic>;
            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                const SizedBox(
                  width: 10,
                ),
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(title, style: Theme.of(context).textTheme.titleLarge)
              ]),
              ...children.map((e) => ListTile(
                    title: Text(e.id.toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                    subtitle: Text(
                      e.description.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/$id/${e.id}');
                    },
                  )),
            ]);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: '菜单',
        child: const Icon(Icons.menu),
      ),
    );
  }
}
