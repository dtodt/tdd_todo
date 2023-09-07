import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

const task = Task(id: 1, description: 'description');
const taskChecked = Task(id: 1, description: 'description', checked: true);

void main() {
  final repository = BoardRepositoryMock();
  final cubit = BoardCubit(repository);

  tearDown(() {
    reset(repository);

    cubit.clear();
  });

  group('fetchTasks |', () {
    test('should retrieve all tasks', () async {
      // Arrange
      when(() => repository.fetch()).thenAnswer((_) async => []);

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

  group('addTask |', () {
    test('should add a task', () async {
      // Arrange
      when(() => repository.update([task])).thenAnswer((_) async => []);

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadedBoardState>(),
        ]),
      );

      // Act
      await cubit.addTask(task);

      // Assert
      final state = cubit.state as LoadedBoardState;
      expect(state.tasks, hasLength(1));
      expect(state.tasks, [task]);
    });

    test('should emit failure on error', () async {
      // Arrange
      when(() => repository.update([task])).thenThrow(Exception());

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<FailureBoardState>(),
        ]),
      );

      // Act
      await cubit.addTask(task);
    });
  });

  group('removeTask |', () {
    test('should remove a task', () async {
      // Arrange
      when(() => repository.update([])).thenAnswer((_) async => []);
      cubit.addTasks([task]);

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadedBoardState>(),
        ]),
      );

      // Act
      await cubit.removeTask(task);

      // Assert
      final state = cubit.state as LoadedBoardState;
      expect(state.tasks, isEmpty);
    });

    test('should emit failure on error', () async {
      // Arrange
      when(() => repository.update([])).thenThrow(Exception());
      cubit.addTasks([task]);

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<FailureBoardState>(),
        ]),
      );

      // Act
      await cubit.removeTask(task);
    });
  });

  group('checkTask |', () {
    test('should check a task', () async {
      // Arrange
      when(() => repository.update([taskChecked])).thenAnswer((_) async => []);
      cubit.addTasks([task]);

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadedBoardState>(),
        ]),
      );

      // Act
      await cubit.checkTask(task);

      // Assert
      final state = cubit.state as LoadedBoardState;
      expect(state.tasks, hasLength(1));
      expect(state.tasks, [taskChecked]);
    });

    test('should emit failure on error', () async {
      // Arrange
      when(() => repository.update([task])).thenThrow(Exception());

      // Assert
      expect(
        cubit.stream,
        emitsInOrder([
          isA<FailureBoardState>(),
        ]),
      );

      // Act
      await cubit.checkTask(task);
    });
  });
}
