import 'package:flutter/material.dart';
import 'package:hello_flutter/states/provider/provider_page.dart';
import 'package:provider/provider.dart';

import 'list_state.dart';

class ProviderDemo extends StatelessWidget {
  const ProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<WidgetListState>(
              create: (_) => WidgetListState()),
        ],
        // 通过tab切换page1 和 page2
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('ProviderDemo'),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Page1'),
                      Tab(text: 'Page2'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    ProviderPage(title: 'Page1'),
                    ProviderPage(title: 'Page2', color: Colors.green),
                  ],
                ),
                // 显示新增按钮，添加数据和跳转按钮
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Consumer<WidgetListState>(
                  builder: (context, state, child) {
                    return FloatingActionButton(
                      heroTag: 'ProviderPage',
                      onPressed: () => state.addWidget(Text(
                          'New Item ${state.widgets.length + 1} from root')),
                      child: const Icon(Icons.add),
                    );
                  },
                ))));
  }
}
