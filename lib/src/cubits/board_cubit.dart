import 'package:bloc/bloc.dart';
import 'package:todo/src/repositories/board_repository.dart';

import '../models/task.dart';
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

  Future<void> addTask(Task task) async {}

  Future<void> removeTask(Task task) async {}

  Future<void> checkTask(Task task) async {}
}
