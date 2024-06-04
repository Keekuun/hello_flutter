import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          EasyLoading.show(status: 'loading...');
          await context.read<TodoCubit>().addTodo(createATodo());
          // 滚动到顶部
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            listController.animateTo(
              // listController.position.maxScrollExtent 滚动到底部
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          });
          EasyLoading.showSuccess('添加成功');
          // Fluttertoast.showToast(
          //   msg: '添加成功',
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.CENTER,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
          // showBottomSheet(
          //     context: context, builder: (context) => const ToDoForm());
        },
        tooltip: '新建todo',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
