import 'package:bloc/bloc.dart';

import '../models/task.dart';
import '../states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(EmptyBoardState());

  Future<void> fetchTasks() async {}

  Future<void> addTask(Task task) async {}

  Future<void> removeTask(Task task) async {}

  Future<void> checkTask(Task task) async {}
}
