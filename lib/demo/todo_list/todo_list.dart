import 'package:flutter/material.dart';

import 'todo_model.dart';

class ToDoList extends StatefulWidget {
  final List<TodoModel> todoListData;

  final ScrollController? controller;

  const ToDoList(this.todoListData, this.controller, {super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 80),
      child: ListView.separated(
        controller: widget.controller,
        shrinkWrap: true,
        itemCount: widget.todoListData.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(widget.todoListData[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(widget.todoListData[index].remark),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        // 使用富文本实现 TextIndent
                        child: Text.rich(TextSpan(children: [
                          const WidgetSpan(
                            child: SizedBox(
                              width: 20,
                              child: VerticalDivider(),
                            ),
                          ),
                          TextSpan(
                            text: widget.todoListData[index].content,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ])),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
