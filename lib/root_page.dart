import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/routes.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  int activeTab = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 0, length: rootTabsData.length, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'hello flutter',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (i) {
            _tabController.animateTo(i);
            setState(() {
              activeTab = i;
            });
          },
          children: rootTabPages,
        ),
        bottomNavigationBar: ConvexAppBar(
          controller: _tabController,
          backgroundColor: Theme.of(context).colorScheme.primary,
          style: TabStyle.react,
          activeColor: Colors.white,
          color: Colors.white54,
          // items: const [
          //   TabItem(icon: Icons.home, title: '首页'),
          //   TabItem(icon: Icons.list, title: '列表'),
          // ],
          items: rootTabsData.asMap().entries.map((entry) {
            var index = entry.key;
            var d = entry.value;
            var icon = d['icon'] as IconData?;
            var color = activeTab == index ? Colors.white : Colors.white54;
            return TabItem(
                icon: Icon(icon, color: color), title: d['title'].toString());
          }).toList(),
          initialActiveIndex: activeTab,
          onTap: (int i) {
            setState(() {
              _pageController.jumpToPage(i);
            });
          },
        ),
      ),
    );
  }
}
