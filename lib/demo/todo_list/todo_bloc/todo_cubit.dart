import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoInitial([]));

  Future<void> addTodo(TodoModel todo) async {
    emit(TodoInitial([todo, ...state.todos]));
    await Future.delayed(const Duration(seconds: 5));
  }

  void removeTodo(TodoModel todo) {
    emit(TodoInitial(state.todos.where((e) => e.id != todo.id).toList()));
  }

  void updateTodo(TodoModel todo) {
    emit(TodoInitial(
        state.todos.map((e) => e.id == todo.id ? todo : e).toList()));
  }
}
