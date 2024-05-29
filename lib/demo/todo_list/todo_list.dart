import 'package:flutter/material.dart';
import 'package:hello_flutter/demo/todo_list/todo_model.dart';
import 'package:uuid/uuid.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var todoListData = <TodoModel>[];

  TodoModel createATodo() {
    var uuid = const Uuid().v4().toString();
    return TodoModel(
        title: '标题${uuid.substring(0, 3)}',
        content: '内容${uuid * 4}',
        remark: '备注${uuid.substring(0, 6)}',
        operator: 'zkk$uuid');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    for (var i = 0; i < 10; i++) {
      todoListData.add(createATodo());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: todoListData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(todoListData[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        subtitle: Text(todoListData[index].remark),
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
                                  text: todoListData[index].content,
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
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                todoListData.insert(0, createATodo());
              });
            },
            child: const Text('添加'))
      ],
    );
  }
}
