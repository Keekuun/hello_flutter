import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                child: ToDoContent(todo),
              ),
            );
          }),
    );
  }
}

class ToDoContent extends StatelessWidget {
  final TodoModel todo;

  const ToDoContent(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: AutoSizeText(
                  todo.title,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                subtitle: Text(todo.remark,
                    style: const TextStyle(color: Colors.white)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: RichText(
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const WidgetSpan(
                      child: SizedBox(
                        width: 20,
                        child: VerticalDivider(),
                      ),
                    ),
                    TextSpan(
                      text: todo.content,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ]),
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined,
                    size: 32, color: Colors.white),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            clipBehavior: Clip.antiAlias,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
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
                              ],
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(todo.imageUrl),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                colorFilter: const ColorFilter.mode(
                                    Colors.black, BlendMode.lighten),
                                opacity: 0.66,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(todo.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white)),
                                  subtitle: Text(todo.remark,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6),
                                  child: RichText(
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      const WidgetSpan(
                                        child: SizedBox(
                                          width: 20,
                                          child: VerticalDivider(),
                                        ),
                                      ),
                                      TextSpan(
                                        text: todo.content,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white70),
                                      ),
                                    ]),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                      textAlign: TextAlign.right,
                                      DateFormat('yyyy-MM-dd HH:mm:ss')
                                          .format(todo.createTime),
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
