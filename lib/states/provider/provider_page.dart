import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_state.dart';

class ProviderPage extends StatelessWidget {
  final String title;
  final Color color;

  const ProviderPage(
      {super.key, required this.title, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetListState>(
      builder: (context, state, child) {
        if (state.widgets.isEmpty) {
          // 显示空状态
          return const Center(child: Text('Empty'));
        }
        return Column(
          children: [
            Text(title),
            Expanded(
              child: ListView.builder(
                itemCount: state.widgets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: state.widgets[index],
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => state.removeWidgetAt(index),
                    ),
                  );
                },
              ),
            ),
            // 新增按钮
            ElevatedButton(
              onPressed: () => state.addWidget(Text(
                'New Item ${state.widgets.length + 1} from $title',
                style: TextStyle(fontSize: 18, color: color),
              )),
              child: const Text('Add'),
            ),
            const SizedBox(height: 80)
          ],
        );
      },
    );
  }
}
