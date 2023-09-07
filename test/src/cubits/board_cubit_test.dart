import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  final repository = BoardRepositoryMock();
  final cubit = BoardCubit(repository);

  tearDown(() => reset(repository));

  group('fetchTasks |', () {
    test('should retrieve all tasks', () async {
      // Arrange
      when(
        () => repository.fetch(),
      ).thenAnswer(
        (_) async => [const Task(id: 1, description: 'description')],
      );

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

    test('should emit failure on error', () async {
      // Arrange
      when(
        () => repository.fetch(),
      ).thenThrow(Exception());

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<FailureBoardState>(),
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
