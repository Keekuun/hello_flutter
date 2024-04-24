import 'package:flutter/material.dart';
import 'package:hello_flutter/routes.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = -1;
  final ScrollController _scrollController = ScrollController();
  late ListObserverController _observerController;

  @override
  void initState() {
    super.initState();

    _observerController = ListObserverController(controller: _scrollController)
      ..initialIndexModel = ObserverIndexPositionModel(
        index: routesList.length - 1, // 默认定位到最后一个
      );
  }

  @override
  void dispose() {
    _observerController.controller?.dispose();
    super.dispose();
  }

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
      body: ListViewObserver(
        autoTriggerObserveTypes: const [
          // ObserverAutoTriggerObserveType.scrollUpdate,
          ObserverAutoTriggerObserveType.scrollStart,
        ],
        triggerOnObserveType: ObserverTriggerOnObserveType.directly,
        controller: _observerController,
        onObserve: (resultModel) {
          // log(resultModel.displayingChildIndexList.toString());
          setState(() {
            currentIndex = resultModel.displayingChildIndexList.last;
          });
        },
        child: _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: null,
        onPressed: null,
        child: PopupMenuButton(
            tooltip: '菜单',
            color: Colors.black54,
            icon: const Icon(Icons.menu),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            itemBuilder: (context) {
              // return routesList.map((d) {
              return routesList.asMap().entries.map((entry) {
                int index = entry.key;
                var d = entry.value;
                var id = d['id']! as String;
                var title = d['title']! as String;
                var icon = d['icon']! as Icon;
                return PopupMenuItem(
                    value: id,
                    onTap: () {
                      _observerController
                          .animateTo(
                        index: index,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      )
                          .then((value) {
                        setState(() {
                          currentIndex = index;
                        });
                      });
                    },
                    child: Row(children: [
                      Icon(icon.icon, color: Colors.redAccent),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.redAccent)),
                    ]));
              }).toList();
            }),
      ),
    );
  }

  ListView _buildListView() {
    return ListView(
      controller: _scrollController,
      children: routesList.asMap().entries.map((entry) {
        var index = entry.key;
        var d = entry.value;
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
            Icon(icon.icon,
                color: currentIndex == index ? Colors.redAccent : null),
            const SizedBox(
              width: 10,
            ),
            Text(title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: currentIndex == index ? Colors.redAccent : null)),
          ]),
          ...children.map((e) => ListTile(
                title: Text(e.id.toString(),
                    style: Theme.of(context).textTheme.bodyLarge),
                subtitle: Text(
                  e.description.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/$id/${e.id}');
                },
              )),
        ]);
      }).toList(),
    );
  }
}
