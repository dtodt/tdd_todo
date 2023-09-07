import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/repositories/isar/isar_board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';
import 'package:todo/src/repositories/isar/task_model.dart';

class IsarBoardDatasourceMock extends Mock implements IsarBoardDatasource {}

void main() {
  final datasource = IsarBoardDatasourceMock();
  final repository = IsarBoardRepository(datasource);

  tearDown(() => reset(datasource));

  group('fetch |', () {
    test('should retrieve all tasks', () async {
      // Arrange
      when(() => datasource.getTasks()).thenAnswer((_) async => [
            TaskModel()..id = 1,
          ]);

      // Act
      final tasks = await repository.fetch();

      // Assert
      expect(tasks, hasLength(1));
    });
  });

  group('update |', () {});
}
