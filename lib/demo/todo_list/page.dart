import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'todo_list.dart';

class TodoListDemo extends StatelessWidget {
  const TodoListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return ToDoList();
  }
}
