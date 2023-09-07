import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  final repository = BoardRepositoryMock();
  final cubit = BoardCubit(repository);

  group('fetchTasks |', () {
    test('should retrieve all tasks', () async {
      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<LoadedBoardState>(),
        ]),
      );

      // Act
      await cubit.fetchTasks();
    });
  });
  // group('addTask |', () { });
  // group('removeTask |', () { });
  // group('checkTask |', () { });
}
