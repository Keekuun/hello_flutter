import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_flutter/demo/todo_list/todo_bloc/todo_cubit.dart';
import 'package:hello_flutter/demo/todo_list/todo_model.dart';

import 'todo_list.dart';

class TodoListDemo extends StatelessWidget {
  const TodoListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: TodoListWrap(),
    );
  }
}

class TodoListWrap extends StatelessWidget {
  TodoListWrap({super.key});

  final listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return ToDoList(state.todos, listController);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 0,
        onPressed: () async {
          // todo 显示 loading
          // EasyLoading.show(status: 'loading...');

          await context.read<TodoCubit>().addTodo(createATodo());
          // todo fix 滚动到顶部 ?
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            listController.animateTo(
              listController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
            );
          });

          // todo 隐藏 loading
          // EasyLoading.dismiss();

          Fluttertoast.showToast(
            msg: '添加成功',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // showBottomSheet(
          //     context: context, builder: (context) => const ToDoForm());
        },
        tooltip: '新建todo',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
