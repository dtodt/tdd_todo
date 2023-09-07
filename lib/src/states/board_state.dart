import '../models/task.dart';

sealed class BoardState {}

class LoadingBoardState implements BoardState {}

class LoadedBoardState implements BoardState {
  final List<Task> tasks;
  LoadedBoardState(this.tasks);
}

class EmptyBoardState extends LoadedBoardState {
  EmptyBoardState() : super([]);
}

class FailureBoardState implements BoardState {
  final String message;
  FailureBoardState(this.message);
}
