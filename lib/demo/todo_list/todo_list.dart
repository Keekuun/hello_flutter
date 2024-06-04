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
      child: ListView.builder(
          controller: widget.controller,
          shrinkWrap: true,
          itemCount: widget.todoListData.length,
          itemBuilder: (context, index) {
            var todo = widget.todoListData[index];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              surfaceTintColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white12,
                          offset: Offset(0, 5),
                          blurRadius: 10),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -5),
                          blurRadius: 10),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 0),
                          blurRadius: 10),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(-5, 0),
                          blurRadius: 10),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(todo.imageUrl),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      colorFilter: const ColorFilter.mode(
                          Colors.black, BlendMode.lighten),
                      opacity: 0.66,
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(todo.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                      subtitle: Text(todo.remark,
                          style: const TextStyle(color: Colors.white)),
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
                                text: todo.content,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.greenAccent),
                              ),
                            ])),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
