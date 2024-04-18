part of 'test_cubit.dart';

sealed class TestState extends Equatable {
  const TestState();
}

final class TestInitial extends TestState {
  @override
  List<Object> get props => [];
}
