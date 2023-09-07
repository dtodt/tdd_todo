import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../repositories/board_repository.dart';
import '../states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;

  BoardCubit(this.repository) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());
    try {
      final tasks = await repository.fetch();
      emit(LoadedBoardState(tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }

  Future<void> addTask(Task task) async {
    final state = this.state;
    if (state is! LoadedBoardState) return;

    final tasks = state.tasks.toList();
    tasks.add(task);

    try {
      await repository.update(tasks);
      emit(LoadedBoardState(tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }

  Future<void> removeTask(Task task) async {
    final state = this.state;
    if (state is! LoadedBoardState) return;

    final tasks = state.tasks.toList();
    tasks.remove(task);

    try {
      await repository.update(tasks);
      emit(LoadedBoardState(tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }

  Future<void> checkTask(Task task) async {
    final state = this.state;
    if (state is! LoadedBoardState) return;

    final tasks = state.tasks.toList();
    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(checked: !task.checked);

    try {
      await repository.update(tasks);
      emit(LoadedBoardState(tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }

  @visibleForTesting
  void addTasks(List<Task> tasks) {
    emit(LoadedBoardState(tasks));
  }
}
