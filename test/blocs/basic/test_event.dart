part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class TestEventDo extends TestEvent {}

class TestEventUndo extends TestEvent {}

class TestEventDone extends TestEvent {}
