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
    final tasks = _getTasks();
    if (tasks == null) return;

    tasks.add(task);

    await _updateTasks(tasks);
  }

  Future<void> removeTask(Task task) async {
    final tasks = _getTasks();
    if (tasks == null) return;

    tasks.remove(task);

    await _updateTasks(tasks);
  }

  Future<void> checkTask(Task task) async {
    final tasks = _getTasks();
    if (tasks == null) return;

    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(checked: !task.checked);

    await _updateTasks(tasks);
  }

  @visibleForTesting
  void addTasks(List<Task> tasks) {
    emit(LoadedBoardState(tasks));
  }

  List<Task>? _getTasks() {
    final state = this.state;
    if (state is! LoadedBoardState) return null;
    return state.tasks.toList();
  }

  Future<void> _updateTasks(List<Task> tasks) async {
    try {
      await repository.update(tasks);
      emit(LoadedBoardState(tasks));
    } catch (e) {
      emit(FailureBoardState(e.toString()));
    }
  }
}
