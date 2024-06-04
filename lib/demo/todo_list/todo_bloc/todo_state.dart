part of 'todo_cubit.dart';

sealed class TodoState extends Equatable {
  final List<TodoModel> todos;

  // 默认添加一个空的todo
  const TodoState.empty() : todos = const <TodoModel>[];

  const TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  const TodoInitial(super.todos);

  @override
  List<Object> get props => [todos];
}

Future<List<TodoModel>> getDemoTodoList() async {
  var todoListData = <TodoModel>[];
  for (var i = 0; i < 10; i++) {
    var todo = await createATodoWithImage();
    todoListData.add(todo);
  }
  return todoListData;
}
